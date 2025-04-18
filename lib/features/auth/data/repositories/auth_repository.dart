import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:drive_note_app/core/constants/app_constants.dart';
import 'package:drive_note_app/core/errors/app_errors.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: AppConstants.driveScopes,
  );

  // Client ID for OAuth - you should replace these with your actual values
  final ClientId _clientId = ClientId(
    Platform.isAndroid
        ? "YOUR_ANDROID_CLIENT_ID"
        : "YOUR_IOS_CLIENT_ID",
    null, // Client secret is null for mobile apps
  );

  Future<AccessCredentials?> getSavedCredentials() async {
    try {
      final String? accessToken =
          await _secureStorage.read(key: AppConstants.accessTokenKey);
      final String? refreshToken =
          await _secureStorage.read(key: AppConstants.refreshTokenKey);
      final String? expiryStr =
          await _secureStorage.read(key: AppConstants.expiryKey);

      if (accessToken == null || refreshToken == null || expiryStr == null) {
        return null;
      }

      // Parse the expiry time - it's already stored as ISO 8601 which is UTC
      final expiry = DateTime.parse(expiryStr).toUtc();

      if (expiry.isBefore(DateTime.now().toUtc())) {
        // Token has expired, refresh it
        return await _refreshToken(refreshToken);
      }

      return AccessCredentials(
        AccessToken(
          'Bearer',
          accessToken,
          expiry, // Already in UTC format
        ),
        refreshToken,
        AppConstants.driveScopes,
      );
    } catch (e) {
      throw AuthenticationError(
          'Failed to get saved credentials: ${e.toString()}');
    }
  }

  Future<AccessCredentials> _refreshToken(String refreshToken) async {
    try {
      // Use refresh token to get a new access token
      final client = _createClient();
      final credentials = await refreshCredentials(
        _clientId,
        AccessCredentials(
          AccessToken('Bearer', '', DateTime.now().toUtc()), // UTC time
          refreshToken,
          AppConstants.driveScopes,
        ),
        client,
      );

      await _saveCredentials(credentials);
      client.close();
      return credentials;
    } catch (e) {
      throw AuthenticationError('Failed to refresh token: ${e.toString()}');
    }
  }

  Future<void> _saveCredentials(AccessCredentials credentials) async {
    await _secureStorage.write(
      key: AppConstants.accessTokenKey,
      value: credentials.accessToken.data,
    );
    await _secureStorage.write(
      key: AppConstants.refreshTokenKey,
      value: credentials.refreshToken,
    );
    await _secureStorage.write(
      key: AppConstants.expiryKey,
      value: credentials.accessToken.expiry.toIso8601String(),
    );
  }

  Future<AccessCredentials> signIn() async {
    try {
      // Use Google Sign In as the primary method - this is the recommended approach
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) {
        throw AuthenticationError('Google sign in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      if (googleAuth.accessToken == null) {
        throw AuthenticationError('Failed to get access token from Google');
      }

      // Convert the tokens to OAuth2 credentials
      final client = _createClient();

      try {
        // Create credentials from the Google Sign-In result
        // Note: Using UTC time for expiry
        final credentials = AccessCredentials(
          AccessToken(
            'Bearer',
            googleAuth.accessToken!,
            DateTime.now().toUtc().add(const Duration(hours: 1)), // UTC time
          ),
          null, // We don't get a refresh token from Google Sign-In directly
          AppConstants.driveScopes,
        );

        await _saveCredentials(credentials);
        return credentials;
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      if (e is AuthenticationError) {
        rethrow;
      }
      throw AuthenticationError('Authentication failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: AppConstants.accessTokenKey);
    await _secureStorage.delete(key: AppConstants.refreshTokenKey);
    await _secureStorage.delete(key: AppConstants.expiryKey);
  }

  // Helper method to create HTTP client
  Client _createClient() {
    return _HttpClient();
  }
}

// A custom HTTP client implementation for googleapis_auth
class _HttpClient extends BaseClient {
  final _client = HttpClient();

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final httpRequest = await _client.openUrl(
      request.method,
      Uri.parse(request.url.toString()),
    );

    request.headers.forEach((name, value) {
      httpRequest.headers.set(name, value);
    });

    if (request is Request && request.body.isNotEmpty) {
      httpRequest.write(request.body);
    }

    final httpResponse = await httpRequest.close();

    // Convert the HttpClientResponse to a StreamedResponse
    final List<int> responseBytes = await httpResponse.fold<List<int>>(
      <int>[],
      (previous, element) => previous..addAll(element),
    );
    // Convert HttpHeaders to Map<String, String>
    final Map<String, String> headersMap = {};
    httpResponse.headers.forEach((name, values) {
      headersMap[name] = values.join(',');
    });

    return StreamedResponse(
      Stream.value(responseBytes),
      httpResponse.statusCode,
      headers: headersMap,
      reasonPhrase: httpResponse.reasonPhrase,
    );
  }

  // Close the client when done
  @override
  void close() {
    _client.close();
  }
}

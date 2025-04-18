import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:googleapis_auth/auth_io.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = UnauthenticatedState;
  const factory AuthState.authenticating() = AuthenticatingState;
  const factory AuthState.authenticated(AccessCredentials credentials) = AuthenticatedState;
  const factory AuthState.error(String message) = AuthErrorState;
}
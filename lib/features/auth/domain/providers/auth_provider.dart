import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:drive_note_app/features/auth/data/services/auth_persistence_service.dart';

final authPersistenceServiceProvider = Provider<AuthPersistenceService>((ref) {
  return AuthPersistenceService();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authPersistenceServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthPersistenceService _persistenceService;

  AuthNotifier(this._persistenceService) : super(const AuthState.initial()) {
    _checkExistingAuth();
  }

  Future<void> _checkExistingAuth() async {
    final isSignedIn = await _persistenceService.isUserSignedIn();
    if (isSignedIn) {
      state = const AuthState.authenticated();
    }
  }

  Future<void> signIn(AccessCredentials credentials) async {
    state = const AuthState.authenticated();
    await _persistenceService.setUserSignedIn(true);
  }

  Future<void> signOut() async {
    state = const AuthState.unauthenticated();
    await _persistenceService.setUserSignedIn(false);
  }
}

sealed class AuthState {
  const AuthState();

  const factory AuthState.initial() = InitialAuthState;
  const factory AuthState.authenticated() = AuthenticatedAuthState;
  const factory AuthState.unauthenticated() = UnauthenticatedAuthState;

  bool get isAuthenticated => this is AuthenticatedAuthState;

  T when<T>({
    required T Function() initial,
    required T Function() authenticated,
    required T Function() unauthenticated,
  }) {
    return switch (this) {
      InitialAuthState() => initial(),
      AuthenticatedAuthState() => authenticated(),
      UnauthenticatedAuthState() => unauthenticated(),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? authenticated,
    T Function()? unauthenticated,
    required T Function() orElse,
  }) {
    return switch (this) {
      InitialAuthState() => initial?.call() ?? orElse(),
      AuthenticatedAuthState() => authenticated?.call() ?? orElse(),
      UnauthenticatedAuthState() => unauthenticated?.call() ?? orElse(),
    };
  }
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class AuthenticatedAuthState extends AuthState {
  const AuthenticatedAuthState();
}

class UnauthenticatedAuthState extends AuthState {
  const UnauthenticatedAuthState();
}

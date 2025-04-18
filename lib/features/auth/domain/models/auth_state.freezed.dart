// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(AccessCredentials credentials) authenticated,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(AccessCredentials credentials)? authenticated,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(AccessCredentials credentials)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnauthenticatedState value) unauthenticated,
    required TResult Function(AuthenticatingState value) authenticating,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(AuthErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnauthenticatedState value)? unauthenticated,
    TResult? Function(AuthenticatingState value)? authenticating,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(AuthErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnauthenticatedState value)? unauthenticated,
    TResult Function(AuthenticatingState value)? authenticating,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(AuthErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnauthenticatedStateImplCopyWith<$Res> {
  factory _$$UnauthenticatedStateImplCopyWith(_$UnauthenticatedStateImpl value,
          $Res Function(_$UnauthenticatedStateImpl) then) =
      __$$UnauthenticatedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedStateImpl>
    implements _$$UnauthenticatedStateImplCopyWith<$Res> {
  __$$UnauthenticatedStateImplCopyWithImpl(_$UnauthenticatedStateImpl _value,
      $Res Function(_$UnauthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedStateImpl implements UnauthenticatedState {
  const _$UnauthenticatedStateImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthenticatedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(AccessCredentials credentials) authenticated,
    required TResult Function(String message) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(AccessCredentials credentials)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(AccessCredentials credentials)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnauthenticatedState value) unauthenticated,
    required TResult Function(AuthenticatingState value) authenticating,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(AuthErrorState value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnauthenticatedState value)? unauthenticated,
    TResult? Function(AuthenticatingState value)? authenticating,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(AuthErrorState value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnauthenticatedState value)? unauthenticated,
    TResult Function(AuthenticatingState value)? authenticating,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(AuthErrorState value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class UnauthenticatedState implements AuthState {
  const factory UnauthenticatedState() = _$UnauthenticatedStateImpl;
}

/// @nodoc
abstract class _$$AuthenticatingStateImplCopyWith<$Res> {
  factory _$$AuthenticatingStateImplCopyWith(_$AuthenticatingStateImpl value,
          $Res Function(_$AuthenticatingStateImpl) then) =
      __$$AuthenticatingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatingStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatingStateImpl>
    implements _$$AuthenticatingStateImplCopyWith<$Res> {
  __$$AuthenticatingStateImplCopyWithImpl(_$AuthenticatingStateImpl _value,
      $Res Function(_$AuthenticatingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticatingStateImpl implements AuthenticatingState {
  const _$AuthenticatingStateImpl();

  @override
  String toString() {
    return 'AuthState.authenticating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(AccessCredentials credentials) authenticated,
    required TResult Function(String message) error,
  }) {
    return authenticating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(AccessCredentials credentials)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return authenticating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(AccessCredentials credentials)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnauthenticatedState value) unauthenticated,
    required TResult Function(AuthenticatingState value) authenticating,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(AuthErrorState value) error,
  }) {
    return authenticating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnauthenticatedState value)? unauthenticated,
    TResult? Function(AuthenticatingState value)? authenticating,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(AuthErrorState value)? error,
  }) {
    return authenticating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnauthenticatedState value)? unauthenticated,
    TResult Function(AuthenticatingState value)? authenticating,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(AuthErrorState value)? error,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(this);
    }
    return orElse();
  }
}

abstract class AuthenticatingState implements AuthState {
  const factory AuthenticatingState() = _$AuthenticatingStateImpl;
}

/// @nodoc
abstract class _$$AuthenticatedStateImplCopyWith<$Res> {
  factory _$$AuthenticatedStateImplCopyWith(_$AuthenticatedStateImpl value,
          $Res Function(_$AuthenticatedStateImpl) then) =
      __$$AuthenticatedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AccessCredentials credentials});
}

/// @nodoc
class __$$AuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedStateImpl>
    implements _$$AuthenticatedStateImplCopyWith<$Res> {
  __$$AuthenticatedStateImplCopyWithImpl(_$AuthenticatedStateImpl _value,
      $Res Function(_$AuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
  }) {
    return _then(_$AuthenticatedStateImpl(
      null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as AccessCredentials,
    ));
  }
}

/// @nodoc

class _$AuthenticatedStateImpl implements AuthenticatedState {
  const _$AuthenticatedStateImpl(this.credentials);

  @override
  final AccessCredentials credentials;

  @override
  String toString() {
    return 'AuthState.authenticated(credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedStateImpl &&
            (identical(other.credentials, credentials) ||
                other.credentials == credentials));
  }

  @override
  int get hashCode => Object.hash(runtimeType, credentials);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      __$$AuthenticatedStateImplCopyWithImpl<_$AuthenticatedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(AccessCredentials credentials) authenticated,
    required TResult Function(String message) error,
  }) {
    return authenticated(credentials);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(AccessCredentials credentials)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return authenticated?.call(credentials);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(AccessCredentials credentials)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(credentials);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnauthenticatedState value) unauthenticated,
    required TResult Function(AuthenticatingState value) authenticating,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(AuthErrorState value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnauthenticatedState value)? unauthenticated,
    TResult? Function(AuthenticatingState value)? authenticating,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(AuthErrorState value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnauthenticatedState value)? unauthenticated,
    TResult Function(AuthenticatingState value)? authenticating,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(AuthErrorState value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedState implements AuthState {
  const factory AuthenticatedState(final AccessCredentials credentials) =
      _$AuthenticatedStateImpl;

  AccessCredentials get credentials;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorStateImplCopyWith<$Res> {
  factory _$$AuthErrorStateImplCopyWith(_$AuthErrorStateImpl value,
          $Res Function(_$AuthErrorStateImpl) then) =
      __$$AuthErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorStateImpl>
    implements _$$AuthErrorStateImplCopyWith<$Res> {
  __$$AuthErrorStateImplCopyWithImpl(
      _$AuthErrorStateImpl _value, $Res Function(_$AuthErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorStateImpl implements AuthErrorState {
  const _$AuthErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorStateImplCopyWith<_$AuthErrorStateImpl> get copyWith =>
      __$$AuthErrorStateImplCopyWithImpl<_$AuthErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(AccessCredentials credentials) authenticated,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(AccessCredentials credentials)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(AccessCredentials credentials)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnauthenticatedState value) unauthenticated,
    required TResult Function(AuthenticatingState value) authenticating,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(AuthErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnauthenticatedState value)? unauthenticated,
    TResult? Function(AuthenticatingState value)? authenticating,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(AuthErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnauthenticatedState value)? unauthenticated,
    TResult Function(AuthenticatingState value)? authenticating,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(AuthErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthErrorState implements AuthState {
  const factory AuthErrorState(final String message) = _$AuthErrorStateImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorStateImplCopyWith<_$AuthErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

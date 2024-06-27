// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationInitialImplCopyWith<$Res> {
  factory _$$AuthenticationInitialImplCopyWith(
          _$AuthenticationInitialImpl value,
          $Res Function(_$AuthenticationInitialImpl) then) =
      __$$AuthenticationInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationInitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationInitialImpl>
    implements _$$AuthenticationInitialImplCopyWith<$Res> {
  __$$AuthenticationInitialImplCopyWithImpl(_$AuthenticationInitialImpl _value,
      $Res Function(_$AuthenticationInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationInitialImpl implements AuthenticationInitial {
  const _$AuthenticationInitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthenticationInitial implements AuthenticationState {
  const factory AuthenticationInitial() = _$AuthenticationInitialImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationLoadingImplCopyWith(
          _$AuthenticationLoadingImpl value,
          $Res Function(_$AuthenticationLoadingImpl) then) =
      __$$AuthenticationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoadingImpl>
    implements _$$AuthenticationLoadingImplCopyWith<$Res> {
  __$$AuthenticationLoadingImplCopyWithImpl(_$AuthenticationLoadingImpl _value,
      $Res Function(_$AuthenticationLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoadingImpl implements AuthenticationLoading {
  const _$AuthenticationLoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoading implements AuthenticationState {
  const factory AuthenticationLoading() = _$AuthenticationLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoadedImplCopyWith<$Res> {
  factory _$$AuthenticationLoadedImplCopyWith(_$AuthenticationLoadedImpl value,
          $Res Function(_$AuthenticationLoadedImpl) then) =
      __$$AuthenticationLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoadedImpl>
    implements _$$AuthenticationLoadedImplCopyWith<$Res> {
  __$$AuthenticationLoadedImplCopyWithImpl(_$AuthenticationLoadedImpl _value,
      $Res Function(_$AuthenticationLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoadedImpl implements AuthenticationLoaded {
  const _$AuthenticationLoadedImpl();

  @override
  String toString() {
    return 'AuthenticationState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoaded implements AuthenticationState {
  const factory AuthenticationLoaded() = _$AuthenticationLoadedImpl;
}

/// @nodoc
abstract class _$$AuthenticationFailedImplCopyWith<$Res> {
  factory _$$AuthenticationFailedImplCopyWith(_$AuthenticationFailedImpl value,
          $Res Function(_$AuthenticationFailedImpl) then) =
      __$$AuthenticationFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationFailedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationFailedImpl>
    implements _$$AuthenticationFailedImplCopyWith<$Res> {
  __$$AuthenticationFailedImplCopyWithImpl(_$AuthenticationFailedImpl _value,
      $Res Function(_$AuthenticationFailedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationFailedImpl implements AuthenticationFailed {
  const _$AuthenticationFailedImpl();

  @override
  String toString() {
    return 'AuthenticationState.failed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return failed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return failed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class AuthenticationFailed implements AuthenticationState {
  const factory AuthenticationFailed() = _$AuthenticationFailedImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoggedInImplCopyWith<$Res> {
  factory _$$AuthenticationLoggedInImplCopyWith(
          _$AuthenticationLoggedInImpl value,
          $Res Function(_$AuthenticationLoggedInImpl) then) =
      __$$AuthenticationLoggedInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoggedInImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationLoggedInImpl>
    implements _$$AuthenticationLoggedInImplCopyWith<$Res> {
  __$$AuthenticationLoggedInImplCopyWithImpl(
      _$AuthenticationLoggedInImpl _value,
      $Res Function(_$AuthenticationLoggedInImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoggedInImpl implements AuthenticationLoggedIn {
  const _$AuthenticationLoggedInImpl();

  @override
  String toString() {
    return 'AuthenticationState.loggedIn()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoggedInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return loggedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return loggedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return loggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return loggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoggedIn implements AuthenticationState {
  const factory AuthenticationLoggedIn() = _$AuthenticationLoggedInImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoggedOutImplCopyWith<$Res> {
  factory _$$AuthenticationLoggedOutImplCopyWith(
          _$AuthenticationLoggedOutImpl value,
          $Res Function(_$AuthenticationLoggedOutImpl) then) =
      __$$AuthenticationLoggedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoggedOutImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationLoggedOutImpl>
    implements _$$AuthenticationLoggedOutImplCopyWith<$Res> {
  __$$AuthenticationLoggedOutImplCopyWithImpl(
      _$AuthenticationLoggedOutImpl _value,
      $Res Function(_$AuthenticationLoggedOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoggedOutImpl implements AuthenticationLoggedOut {
  const _$AuthenticationLoggedOutImpl();

  @override
  String toString() {
    return 'AuthenticationState.loggedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoggedOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoggedOut implements AuthenticationState {
  const factory AuthenticationLoggedOut() = _$AuthenticationLoggedOutImpl;
}

/// @nodoc
abstract class _$$AuthenticationErrorImplCopyWith<$Res> {
  factory _$$AuthenticationErrorImplCopyWith(_$AuthenticationErrorImpl value,
          $Res Function(_$AuthenticationErrorImpl) then) =
      __$$AuthenticationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$AuthenticationErrorImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationErrorImpl>
    implements _$$AuthenticationErrorImplCopyWith<$Res> {
  __$$AuthenticationErrorImplCopyWithImpl(_$AuthenticationErrorImpl _value,
      $Res Function(_$AuthenticationErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$AuthenticationErrorImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationErrorImpl implements AuthenticationError {
  const _$AuthenticationErrorImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthenticationState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationErrorImplCopyWith<_$AuthenticationErrorImpl> get copyWith =>
      __$$AuthenticationErrorImplCopyWithImpl<_$AuthenticationErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() failed,
    required TResult Function() loggedIn,
    required TResult Function() loggedOut,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? failed,
    TResult? Function()? loggedIn,
    TResult? Function()? loggedOut,
    TResult? Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? failed,
    TResult Function()? loggedIn,
    TResult Function()? loggedOut,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationLoaded value) loaded,
    required TResult Function(AuthenticationFailed value) failed,
    required TResult Function(AuthenticationLoggedIn value) loggedIn,
    required TResult Function(AuthenticationLoggedOut value) loggedOut,
    required TResult Function(AuthenticationError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationLoaded value)? loaded,
    TResult? Function(AuthenticationFailed value)? failed,
    TResult? Function(AuthenticationLoggedIn value)? loggedIn,
    TResult? Function(AuthenticationLoggedOut value)? loggedOut,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationLoaded value)? loaded,
    TResult Function(AuthenticationFailed value)? failed,
    TResult Function(AuthenticationLoggedIn value)? loggedIn,
    TResult Function(AuthenticationLoggedOut value)? loggedOut,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthenticationError implements AuthenticationState {
  const factory AuthenticationError(final String errorMessage) =
      _$AuthenticationErrorImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$AuthenticationErrorImplCopyWith<_$AuthenticationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

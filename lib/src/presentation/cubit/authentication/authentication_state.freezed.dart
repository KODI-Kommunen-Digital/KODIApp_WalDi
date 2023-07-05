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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$AuthenticationInitialCopyWith<$Res> {
  factory _$$AuthenticationInitialCopyWith(_$AuthenticationInitial value,
          $Res Function(_$AuthenticationInitial) then) =
      __$$AuthenticationInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationInitialCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationInitial>
    implements _$$AuthenticationInitialCopyWith<$Res> {
  __$$AuthenticationInitialCopyWithImpl(_$AuthenticationInitial _value,
      $Res Function(_$AuthenticationInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationInitial implements AuthenticationInitial {
  const _$AuthenticationInitial();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticationInitial);
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
  const factory AuthenticationInitial() = _$AuthenticationInitial;
}

/// @nodoc
abstract class _$$AuthenticationLoadingCopyWith<$Res> {
  factory _$$AuthenticationLoadingCopyWith(_$AuthenticationLoading value,
          $Res Function(_$AuthenticationLoading) then) =
      __$$AuthenticationLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadingCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoading>
    implements _$$AuthenticationLoadingCopyWith<$Res> {
  __$$AuthenticationLoadingCopyWithImpl(_$AuthenticationLoading _value,
      $Res Function(_$AuthenticationLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoading implements AuthenticationLoading {
  const _$AuthenticationLoading();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticationLoading);
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
  const factory AuthenticationLoading() = _$AuthenticationLoading;
}

/// @nodoc
abstract class _$$AuthenticationLoadedCopyWith<$Res> {
  factory _$$AuthenticationLoadedCopyWith(_$AuthenticationLoaded value,
          $Res Function(_$AuthenticationLoaded) then) =
      __$$AuthenticationLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadedCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoaded>
    implements _$$AuthenticationLoadedCopyWith<$Res> {
  __$$AuthenticationLoadedCopyWithImpl(_$AuthenticationLoaded _value,
      $Res Function(_$AuthenticationLoaded) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoaded implements AuthenticationLoaded {
  const _$AuthenticationLoaded();

  @override
  String toString() {
    return 'AuthenticationState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticationLoaded);
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
  const factory AuthenticationLoaded() = _$AuthenticationLoaded;
}

/// @nodoc
abstract class _$$AuthenticationFailedCopyWith<$Res> {
  factory _$$AuthenticationFailedCopyWith(_$AuthenticationFailed value,
          $Res Function(_$AuthenticationFailed) then) =
      __$$AuthenticationFailedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationFailedCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationFailed>
    implements _$$AuthenticationFailedCopyWith<$Res> {
  __$$AuthenticationFailedCopyWithImpl(_$AuthenticationFailed _value,
      $Res Function(_$AuthenticationFailed) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationFailed implements AuthenticationFailed {
  const _$AuthenticationFailed();

  @override
  String toString() {
    return 'AuthenticationState.failed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticationFailed);
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
  const factory AuthenticationFailed() = _$AuthenticationFailed;
}

/// @nodoc
abstract class _$$AuthenticationLoggedInCopyWith<$Res> {
  factory _$$AuthenticationLoggedInCopyWith(_$AuthenticationLoggedIn value,
          $Res Function(_$AuthenticationLoggedIn) then) =
      __$$AuthenticationLoggedInCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoggedInCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoggedIn>
    implements _$$AuthenticationLoggedInCopyWith<$Res> {
  __$$AuthenticationLoggedInCopyWithImpl(_$AuthenticationLoggedIn _value,
      $Res Function(_$AuthenticationLoggedIn) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoggedIn implements AuthenticationLoggedIn {
  const _$AuthenticationLoggedIn();

  @override
  String toString() {
    return 'AuthenticationState.loggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticationLoggedIn);
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
  const factory AuthenticationLoggedIn() = _$AuthenticationLoggedIn;
}

/// @nodoc
abstract class _$$AuthenticationLoggedOutCopyWith<$Res> {
  factory _$$AuthenticationLoggedOutCopyWith(_$AuthenticationLoggedOut value,
          $Res Function(_$AuthenticationLoggedOut) then) =
      __$$AuthenticationLoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoggedOutCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoggedOut>
    implements _$$AuthenticationLoggedOutCopyWith<$Res> {
  __$$AuthenticationLoggedOutCopyWithImpl(_$AuthenticationLoggedOut _value,
      $Res Function(_$AuthenticationLoggedOut) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoggedOut implements AuthenticationLoggedOut {
  const _$AuthenticationLoggedOut();

  @override
  String toString() {
    return 'AuthenticationState.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoggedOut);
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
  const factory AuthenticationLoggedOut() = _$AuthenticationLoggedOut;
}

/// @nodoc
abstract class _$$AuthenticationErrorCopyWith<$Res> {
  factory _$$AuthenticationErrorCopyWith(_$AuthenticationError value,
          $Res Function(_$AuthenticationError) then) =
      __$$AuthenticationErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$AuthenticationErrorCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationError>
    implements _$$AuthenticationErrorCopyWith<$Res> {
  __$$AuthenticationErrorCopyWithImpl(
      _$AuthenticationError _value, $Res Function(_$AuthenticationError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$AuthenticationError(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationError implements AuthenticationError {
  const _$AuthenticationError(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthenticationState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationError &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationErrorCopyWith<_$AuthenticationError> get copyWith =>
      __$$AuthenticationErrorCopyWithImpl<_$AuthenticationError>(
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
      _$AuthenticationError;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$AuthenticationErrorCopyWith<_$AuthenticationError> get copyWith =>
      throw _privateConstructorUsedError;
}

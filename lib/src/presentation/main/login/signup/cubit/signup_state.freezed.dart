// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpStateLoading value) loading,
    required TResult Function(SignUpStateLoaded value) loaded,
    required TResult Function(SignUpStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpStateLoading value)? loading,
    TResult? Function(SignUpStateLoaded value)? loaded,
    TResult? Function(SignUpStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpStateLoading value)? loading,
    TResult Function(SignUpStateLoaded value)? loaded,
    TResult Function(SignUpStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SignUpStateLoadingCopyWith<$Res> {
  factory _$$SignUpStateLoadingCopyWith(_$SignUpStateLoading value,
          $Res Function(_$SignUpStateLoading) then) =
      __$$SignUpStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpStateLoadingCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateLoading>
    implements _$$SignUpStateLoadingCopyWith<$Res> {
  __$$SignUpStateLoadingCopyWithImpl(
      _$SignUpStateLoading _value, $Res Function(_$SignUpStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpStateLoading implements SignUpStateLoading {
  const _$SignUpStateLoading();

  @override
  String toString() {
    return 'SignUpState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? error,
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
    required TResult Function(SignUpStateLoading value) loading,
    required TResult Function(SignUpStateLoaded value) loaded,
    required TResult Function(SignUpStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpStateLoading value)? loading,
    TResult? Function(SignUpStateLoaded value)? loaded,
    TResult? Function(SignUpStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpStateLoading value)? loading,
    TResult Function(SignUpStateLoaded value)? loaded,
    TResult Function(SignUpStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SignUpStateLoading implements SignUpState {
  const factory SignUpStateLoading() = _$SignUpStateLoading;
}

/// @nodoc
abstract class _$$SignUpStateLoadedCopyWith<$Res> {
  factory _$$SignUpStateLoadedCopyWith(
          _$SignUpStateLoaded value, $Res Function(_$SignUpStateLoaded) then) =
      __$$SignUpStateLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpStateLoadedCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateLoaded>
    implements _$$SignUpStateLoadedCopyWith<$Res> {
  __$$SignUpStateLoadedCopyWithImpl(
      _$SignUpStateLoaded _value, $Res Function(_$SignUpStateLoaded) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpStateLoaded implements SignUpStateLoaded {
  const _$SignUpStateLoaded();

  @override
  String toString() {
    return 'SignUpState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpStateLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? error,
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
    required TResult Function(SignUpStateLoading value) loading,
    required TResult Function(SignUpStateLoaded value) loaded,
    required TResult Function(SignUpStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpStateLoading value)? loading,
    TResult? Function(SignUpStateLoaded value)? loaded,
    TResult? Function(SignUpStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpStateLoading value)? loading,
    TResult Function(SignUpStateLoaded value)? loaded,
    TResult Function(SignUpStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SignUpStateLoaded implements SignUpState {
  const factory SignUpStateLoaded() = _$SignUpStateLoaded;
}

/// @nodoc
abstract class _$$SignUpStateErrorCopyWith<$Res> {
  factory _$$SignUpStateErrorCopyWith(
          _$SignUpStateError value, $Res Function(_$SignUpStateError) then) =
      __$$SignUpStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpStateErrorCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateError>
    implements _$$SignUpStateErrorCopyWith<$Res> {
  __$$SignUpStateErrorCopyWithImpl(
      _$SignUpStateError _value, $Res Function(_$SignUpStateError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpStateError implements SignUpStateError {
  const _$SignUpStateError();

  @override
  String toString() {
    return 'SignUpState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpStateError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpStateLoading value) loading,
    required TResult Function(SignUpStateLoaded value) loaded,
    required TResult Function(SignUpStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpStateLoading value)? loading,
    TResult? Function(SignUpStateLoaded value)? loaded,
    TResult? Function(SignUpStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpStateLoading value)? loading,
    TResult Function(SignUpStateLoaded value)? loaded,
    TResult Function(SignUpStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SignUpStateError implements SignUpState {
  const factory SignUpStateError() = _$SignUpStateError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApplicationState {
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
    required TResult Function(ApplicationLoading value) loading,
    required TResult Function(ApplicationLoaded value) loaded,
    required TResult Function(ApplicationError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApplicationLoading value)? loading,
    TResult? Function(ApplicationLoaded value)? loaded,
    TResult? Function(ApplicationError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApplicationLoading value)? loading,
    TResult Function(ApplicationLoaded value)? loaded,
    TResult Function(ApplicationError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationStateCopyWith<$Res> {
  factory $ApplicationStateCopyWith(
          ApplicationState value, $Res Function(ApplicationState) then) =
      _$ApplicationStateCopyWithImpl<$Res, ApplicationState>;
}

/// @nodoc
class _$ApplicationStateCopyWithImpl<$Res, $Val extends ApplicationState>
    implements $ApplicationStateCopyWith<$Res> {
  _$ApplicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApplicationLoadingImplCopyWith<$Res> {
  factory _$$ApplicationLoadingImplCopyWith(_$ApplicationLoadingImpl value,
          $Res Function(_$ApplicationLoadingImpl) then) =
      __$$ApplicationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApplicationLoadingImplCopyWithImpl<$Res>
    extends _$ApplicationStateCopyWithImpl<$Res, _$ApplicationLoadingImpl>
    implements _$$ApplicationLoadingImplCopyWith<$Res> {
  __$$ApplicationLoadingImplCopyWithImpl(_$ApplicationLoadingImpl _value,
      $Res Function(_$ApplicationLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApplicationLoadingImpl implements ApplicationLoading {
  const _$ApplicationLoadingImpl();

  @override
  String toString() {
    return 'ApplicationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApplicationLoadingImpl);
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
    required TResult Function(ApplicationLoading value) loading,
    required TResult Function(ApplicationLoaded value) loaded,
    required TResult Function(ApplicationError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApplicationLoading value)? loading,
    TResult? Function(ApplicationLoaded value)? loaded,
    TResult? Function(ApplicationError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApplicationLoading value)? loading,
    TResult Function(ApplicationLoaded value)? loaded,
    TResult Function(ApplicationError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ApplicationLoading implements ApplicationState {
  const factory ApplicationLoading() = _$ApplicationLoadingImpl;
}

/// @nodoc
abstract class _$$ApplicationLoadedImplCopyWith<$Res> {
  factory _$$ApplicationLoadedImplCopyWith(_$ApplicationLoadedImpl value,
          $Res Function(_$ApplicationLoadedImpl) then) =
      __$$ApplicationLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApplicationLoadedImplCopyWithImpl<$Res>
    extends _$ApplicationStateCopyWithImpl<$Res, _$ApplicationLoadedImpl>
    implements _$$ApplicationLoadedImplCopyWith<$Res> {
  __$$ApplicationLoadedImplCopyWithImpl(_$ApplicationLoadedImpl _value,
      $Res Function(_$ApplicationLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApplicationLoadedImpl implements ApplicationLoaded {
  const _$ApplicationLoadedImpl();

  @override
  String toString() {
    return 'ApplicationState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApplicationLoadedImpl);
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
    required TResult Function(ApplicationLoading value) loading,
    required TResult Function(ApplicationLoaded value) loaded,
    required TResult Function(ApplicationError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApplicationLoading value)? loading,
    TResult? Function(ApplicationLoaded value)? loaded,
    TResult? Function(ApplicationError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApplicationLoading value)? loading,
    TResult Function(ApplicationLoaded value)? loaded,
    TResult Function(ApplicationError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ApplicationLoaded implements ApplicationState {
  const factory ApplicationLoaded() = _$ApplicationLoadedImpl;
}

/// @nodoc
abstract class _$$ApplicationErrorImplCopyWith<$Res> {
  factory _$$ApplicationErrorImplCopyWith(_$ApplicationErrorImpl value,
          $Res Function(_$ApplicationErrorImpl) then) =
      __$$ApplicationErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ApplicationErrorImplCopyWithImpl<$Res>
    extends _$ApplicationStateCopyWithImpl<$Res, _$ApplicationErrorImpl>
    implements _$$ApplicationErrorImplCopyWith<$Res> {
  __$$ApplicationErrorImplCopyWithImpl(_$ApplicationErrorImpl _value,
      $Res Function(_$ApplicationErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApplicationErrorImpl implements ApplicationError {
  const _$ApplicationErrorImpl();

  @override
  String toString() {
    return 'ApplicationState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApplicationErrorImpl);
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
    required TResult Function(ApplicationLoading value) loading,
    required TResult Function(ApplicationLoaded value) loaded,
    required TResult Function(ApplicationError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApplicationLoading value)? loading,
    TResult? Function(ApplicationLoaded value)? loaded,
    TResult? Function(ApplicationError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApplicationLoading value)? loading,
    TResult Function(ApplicationLoaded value)? loaded,
    TResult Function(ApplicationError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ApplicationError implements ApplicationState {
  const factory ApplicationError() = _$ApplicationErrorImpl;
}

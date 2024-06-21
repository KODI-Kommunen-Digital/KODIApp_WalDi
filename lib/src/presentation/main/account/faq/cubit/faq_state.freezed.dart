// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FaqState {
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
    required TResult Function(FaqStateLoading value) loading,
    required TResult Function(FaqStateLoaded value) loaded,
    required TResult Function(FaqStateError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FaqStateLoading value)? loading,
    TResult? Function(FaqStateLoaded value)? loaded,
    TResult? Function(FaqStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FaqStateLoading value)? loading,
    TResult Function(FaqStateLoaded value)? loaded,
    TResult Function(FaqStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqStateCopyWith<$Res> {
  factory $FaqStateCopyWith(FaqState value, $Res Function(FaqState) then) =
      _$FaqStateCopyWithImpl<$Res, FaqState>;
}

/// @nodoc
class _$FaqStateCopyWithImpl<$Res, $Val extends FaqState>
    implements $FaqStateCopyWith<$Res> {
  _$FaqStateCopyWithImpl(this._value, this._then);

// ignore: unused_field
  final $Val _value;
// ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FaqStateLoadingCopyWith<$Res> {
  factory _$$FaqStateLoadingCopyWith(
          _$FaqStateLoading value, $Res Function(_$FaqStateLoading) then) =
      __$$FaqStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FaqStateLoadingCopyWithImpl<$Res>
    extends _$FaqStateCopyWithImpl<$Res, _$FaqStateLoading>
    implements _$$FaqStateLoadingCopyWith<$Res> {
  __$$FaqStateLoadingCopyWithImpl(
      _$FaqStateLoading _value, $Res Function(_$FaqStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FaqStateLoading implements FaqStateLoading {
  const _$FaqStateLoading();

  @override
  String toString() {
    return 'FaqState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FaqStateLoading);
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
    required TResult Function(FaqStateLoading value) loading,
    required TResult Function(FaqStateLoaded value) loaded,
    required TResult Function(FaqStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FaqStateLoading value)? loading,
    TResult? Function(FaqStateLoaded value)? loaded,
    TResult? Function(FaqStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FaqStateLoading value)? loading,
    TResult Function(FaqStateLoaded value)? loaded,
    TResult Function(FaqStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FaqStateLoading implements FaqState {
  const factory FaqStateLoading() = _$FaqStateLoading;
}

/// @nodoc
abstract class _$$FaqStateLoadedCopyWith<$Res> {
  factory _$$FaqStateLoadedCopyWith(
          _$FaqStateLoaded value, $Res Function(_$FaqStateLoaded) then) =
      __$$FaqStateLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FaqStateLoadedCopyWithImpl<$Res>
    extends _$FaqStateCopyWithImpl<$Res, _$FaqStateLoaded>
    implements _$$FaqStateLoadedCopyWith<$Res> {
  __$$FaqStateLoadedCopyWithImpl(
      _$FaqStateLoaded _value, $Res Function(_$FaqStateLoaded) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FaqStateLoaded implements FaqStateLoaded {
  const _$FaqStateLoaded();

  @override
  String toString() {
    return 'FaqState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FaqStateLoaded);
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
    required TResult Function(FaqStateLoading value) loading,
    required TResult Function(FaqStateLoaded value) loaded,
    required TResult Function(FaqStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FaqStateLoading value)? loading,
    TResult? Function(FaqStateLoaded value)? loaded,
    TResult? Function(FaqStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FaqStateLoading value)? loading,
    TResult Function(FaqStateLoaded value)? loaded,
    TResult Function(FaqStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FaqStateLoaded implements FaqState {
  const factory FaqStateLoaded() = _$FaqStateLoaded;
}

/// @nodoc
abstract class _$$FaqStateErrorCopyWith<$Res> {
  factory _$$FaqStateErrorCopyWith(
          _$FaqStateError value, $Res Function(_$FaqStateError) then) =
      __$$FaqStateErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FaqStateErrorCopyWithImpl<$Res>
    extends _$FaqStateCopyWithImpl<$Res, _$FaqStateError>
    implements _$$FaqStateErrorCopyWith<$Res> {
  __$$FaqStateErrorCopyWithImpl(
      _$FaqStateError _value, $Res Function(_$FaqStateError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FaqStateError implements FaqStateError {
  const _$FaqStateError();

  @override
  String toString() {
    return 'FaqState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FaqStateError);
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
    required TResult Function(FaqStateLoading value) loading,
    required TResult Function(FaqStateLoaded value) loaded,
    required TResult Function(FaqStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FaqStateLoading value)? loading,
    TResult? Function(FaqStateLoaded value)? loaded,
    TResult? Function(FaqStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FaqStateLoading value)? loading,
    TResult Function(FaqStateLoaded value)? loaded,
    TResult Function(FaqStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FaqStateError implements FaqState {
  const factory FaqStateError() = _$FaqStateError;
}

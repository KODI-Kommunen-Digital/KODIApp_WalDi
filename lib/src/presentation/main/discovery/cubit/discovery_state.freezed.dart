// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DiscoveryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(int cityId) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(int cityId)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(int cityId)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoveryStateCopyWith<$Res> {
  factory $DiscoveryStateCopyWith(
          DiscoveryState value, $Res Function(DiscoveryState) then) =
      _$DiscoveryStateCopyWithImpl<$Res, DiscoveryState>;
}

/// @nodoc
class _$DiscoveryStateCopyWithImpl<$Res, $Val extends DiscoveryState>
    implements $DiscoveryStateCopyWith<$Res> {
  _$DiscoveryStateCopyWithImpl(this._value, this._then);

// ignore: unused_field
  final $Val _value;
// ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DiscoveryStateInitialCopyWith<$Res> {
  factory _$$DiscoveryStateInitialCopyWith(_$DiscoveryStateInitial value,
          $Res Function(_$DiscoveryStateInitial) then) =
      __$$DiscoveryStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DiscoveryStateInitialCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateInitial>
    implements _$$DiscoveryStateInitialCopyWith<$Res> {
  __$$DiscoveryStateInitialCopyWithImpl(_$DiscoveryStateInitial _value,
      $Res Function(_$DiscoveryStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DiscoveryStateInitial implements DiscoveryStateInitial {
  const _$DiscoveryStateInitial();

  @override
  String toString() {
    return 'DiscoveryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DiscoveryStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(int cityId) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(int cityId)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(int cityId)? loaded,
    TResult Function(String error)? error,
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
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class DiscoveryStateInitial implements DiscoveryState {
  const factory DiscoveryStateInitial() = _$DiscoveryStateInitial;
}

/// @nodoc
abstract class _$$DiscoveryStateLoadingCopyWith<$Res> {
  factory _$$DiscoveryStateLoadingCopyWith(_$DiscoveryStateLoading value,
          $Res Function(_$DiscoveryStateLoading) then) =
      __$$DiscoveryStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DiscoveryStateLoadingCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateLoading>
    implements _$$DiscoveryStateLoadingCopyWith<$Res> {
  __$$DiscoveryStateLoadingCopyWithImpl(_$DiscoveryStateLoading _value,
      $Res Function(_$DiscoveryStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DiscoveryStateLoading implements DiscoveryStateLoading {
  const _$DiscoveryStateLoading();

  @override
  String toString() {
    return 'DiscoveryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DiscoveryStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(int cityId) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(int cityId)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(int cityId)? loaded,
    TResult Function(String error)? error,
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
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DiscoveryStateLoading implements DiscoveryState {
  const factory DiscoveryStateLoading() = _$DiscoveryStateLoading;
}

/// @nodoc
abstract class _$$DiscoveryStateLoadedCopyWith<$Res> {
  factory _$$DiscoveryStateLoadedCopyWith(_$DiscoveryStateLoaded value,
          $Res Function(_$DiscoveryStateLoaded) then) =
      __$$DiscoveryStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({int cityId});
}

/// @nodoc
class __$$DiscoveryStateLoadedCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateLoaded>
    implements _$$DiscoveryStateLoadedCopyWith<$Res> {
  __$$DiscoveryStateLoadedCopyWithImpl(_$DiscoveryStateLoaded _value,
      $Res Function(_$DiscoveryStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = null,
  }) {
    return _then(_$DiscoveryStateLoaded(
      null == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DiscoveryStateLoaded implements DiscoveryStateLoaded {
  const _$DiscoveryStateLoaded(this.cityId);

  @override
  final int cityId;

  @override
  String toString() {
    return 'DiscoveryState.loaded(cityId: $cityId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateLoaded &&
            (identical(other.cityId, cityId) || other.cityId == cityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryStateLoadedCopyWith<_$DiscoveryStateLoaded> get copyWith =>
      __$$DiscoveryStateLoadedCopyWithImpl<_$DiscoveryStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(int cityId) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(cityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(int cityId)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(cityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(int cityId)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DiscoveryStateLoaded implements DiscoveryState {
  const factory DiscoveryStateLoaded(final int cityId) = _$DiscoveryStateLoaded;

  int get cityId;
  @JsonKey(ignore: true)
  _$$DiscoveryStateLoadedCopyWith<_$DiscoveryStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiscoveryStateErrorCopyWith<$Res> {
  factory _$$DiscoveryStateErrorCopyWith(_$DiscoveryStateError value,
          $Res Function(_$DiscoveryStateError) then) =
      __$$DiscoveryStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DiscoveryStateErrorCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateError>
    implements _$$DiscoveryStateErrorCopyWith<$Res> {
  __$$DiscoveryStateErrorCopyWithImpl(
      _$DiscoveryStateError _value, $Res Function(_$DiscoveryStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DiscoveryStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DiscoveryStateError implements DiscoveryStateError {
  const _$DiscoveryStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'DiscoveryState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryStateErrorCopyWith<_$DiscoveryStateError> get copyWith =>
      __$$DiscoveryStateErrorCopyWithImpl<_$DiscoveryStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(int cityId) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(int cityId)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(int cityId)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DiscoveryStateError implements DiscoveryState {
  const factory DiscoveryStateError(final String error) = _$DiscoveryStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$DiscoveryStateErrorCopyWith<_$DiscoveryStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiscoveryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateUpdated value) updated,
    required TResult Function(DiscoveryStateError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateUpdated value)? updated,
    TResult? Function(DiscoveryStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateUpdated value)? updated,
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
abstract class _$$DiscoveryStateInitialImplCopyWith<$Res> {
  factory _$$DiscoveryStateInitialImplCopyWith(
          _$DiscoveryStateInitialImpl value,
          $Res Function(_$DiscoveryStateInitialImpl) then) =
      __$$DiscoveryStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DiscoveryStateInitialImplCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateInitialImpl>
    implements _$$DiscoveryStateInitialImplCopyWith<$Res> {
  __$$DiscoveryStateInitialImplCopyWithImpl(_$DiscoveryStateInitialImpl _value,
      $Res Function(_$DiscoveryStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DiscoveryStateInitialImpl implements DiscoveryStateInitial {
  const _$DiscoveryStateInitialImpl();

  @override
  String toString() {
    return 'DiscoveryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
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
    required TResult Function(DiscoveryStateUpdated value) updated,
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
    TResult? Function(DiscoveryStateUpdated value)? updated,
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
    TResult Function(DiscoveryStateUpdated value)? updated,
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
  const factory DiscoveryStateInitial() = _$DiscoveryStateInitialImpl;
}

/// @nodoc
abstract class _$$DiscoveryStateLoadingImplCopyWith<$Res> {
  factory _$$DiscoveryStateLoadingImplCopyWith(
          _$DiscoveryStateLoadingImpl value,
          $Res Function(_$DiscoveryStateLoadingImpl) then) =
      __$$DiscoveryStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DiscoveryStateLoadingImplCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateLoadingImpl>
    implements _$$DiscoveryStateLoadingImplCopyWith<$Res> {
  __$$DiscoveryStateLoadingImplCopyWithImpl(_$DiscoveryStateLoadingImpl _value,
      $Res Function(_$DiscoveryStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DiscoveryStateLoadingImpl implements DiscoveryStateLoading {
  const _$DiscoveryStateLoadingImpl();

  @override
  String toString() {
    return 'DiscoveryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
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
    required TResult Function(DiscoveryStateUpdated value) updated,
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
    TResult? Function(DiscoveryStateUpdated value)? updated,
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
    TResult Function(DiscoveryStateUpdated value)? updated,
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
  const factory DiscoveryStateLoading() = _$DiscoveryStateLoadingImpl;
}

/// @nodoc
abstract class _$$DiscoveryStateLoadedImplCopyWith<$Res> {
  factory _$$DiscoveryStateLoadedImplCopyWith(_$DiscoveryStateLoadedImpl value,
          $Res Function(_$DiscoveryStateLoadedImpl) then) =
      __$$DiscoveryStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CitizenServiceModel> list});
}

/// @nodoc
class __$$DiscoveryStateLoadedImplCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateLoadedImpl>
    implements _$$DiscoveryStateLoadedImplCopyWith<$Res> {
  __$$DiscoveryStateLoadedImplCopyWithImpl(_$DiscoveryStateLoadedImpl _value,
      $Res Function(_$DiscoveryStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$DiscoveryStateLoadedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CitizenServiceModel>,
    ));
  }
}

/// @nodoc

class _$DiscoveryStateLoadedImpl implements DiscoveryStateLoaded {
  const _$DiscoveryStateLoadedImpl(final List<CitizenServiceModel> list)
      : _list = list;

  final List<CitizenServiceModel> _list;
  @override
  List<CitizenServiceModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
// ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'DiscoveryState.loaded(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryStateLoadedImplCopyWith<_$DiscoveryStateLoadedImpl>
      get copyWith =>
          __$$DiscoveryStateLoadedImplCopyWithImpl<_$DiscoveryStateLoadedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateUpdated value) updated,
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
    TResult? Function(DiscoveryStateUpdated value)? updated,
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
    TResult Function(DiscoveryStateUpdated value)? updated,
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
  const factory DiscoveryStateLoaded(final List<CitizenServiceModel> list) =
      _$DiscoveryStateLoadedImpl;

  List<CitizenServiceModel> get list;
  @JsonKey(ignore: true)
  _$$DiscoveryStateLoadedImplCopyWith<_$DiscoveryStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiscoveryStateUpdatedImplCopyWith<$Res> {
  factory _$$DiscoveryStateUpdatedImplCopyWith(
          _$DiscoveryStateUpdatedImpl value,
          $Res Function(_$DiscoveryStateUpdatedImpl) then) =
      __$$DiscoveryStateUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CategoryModel> list});
}

/// @nodoc
class __$$DiscoveryStateUpdatedImplCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateUpdatedImpl>
    implements _$$DiscoveryStateUpdatedImplCopyWith<$Res> {
  __$$DiscoveryStateUpdatedImplCopyWithImpl(_$DiscoveryStateUpdatedImpl _value,
      $Res Function(_$DiscoveryStateUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$DiscoveryStateUpdatedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ));
  }
}

/// @nodoc

class _$DiscoveryStateUpdatedImpl implements DiscoveryStateUpdated {
  const _$DiscoveryStateUpdatedImpl(final List<CategoryModel> list)
      : _list = list;

  final List<CategoryModel> _list;
  @override
  List<CategoryModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
// ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'DiscoveryState.updated(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateUpdatedImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryStateUpdatedImplCopyWith<_$DiscoveryStateUpdatedImpl>
      get copyWith => __$$DiscoveryStateUpdatedImplCopyWithImpl<
          _$DiscoveryStateUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return updated(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return updated?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiscoveryStateInitial value) initial,
    required TResult Function(DiscoveryStateLoading value) loading,
    required TResult Function(DiscoveryStateLoaded value) loaded,
    required TResult Function(DiscoveryStateUpdated value) updated,
    required TResult Function(DiscoveryStateError value) error,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiscoveryStateInitial value)? initial,
    TResult? Function(DiscoveryStateLoading value)? loading,
    TResult? Function(DiscoveryStateLoaded value)? loaded,
    TResult? Function(DiscoveryStateUpdated value)? updated,
    TResult? Function(DiscoveryStateError value)? error,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiscoveryStateInitial value)? initial,
    TResult Function(DiscoveryStateLoading value)? loading,
    TResult Function(DiscoveryStateLoaded value)? loaded,
    TResult Function(DiscoveryStateUpdated value)? updated,
    TResult Function(DiscoveryStateError value)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class DiscoveryStateUpdated implements DiscoveryState {
  const factory DiscoveryStateUpdated(final List<CategoryModel> list) =
      _$DiscoveryStateUpdatedImpl;

  List<CategoryModel> get list;
  @JsonKey(ignore: true)
  _$$DiscoveryStateUpdatedImplCopyWith<_$DiscoveryStateUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiscoveryStateErrorImplCopyWith<$Res> {
  factory _$$DiscoveryStateErrorImplCopyWith(_$DiscoveryStateErrorImpl value,
          $Res Function(_$DiscoveryStateErrorImpl) then) =
      __$$DiscoveryStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$DiscoveryStateErrorImplCopyWithImpl<$Res>
    extends _$DiscoveryStateCopyWithImpl<$Res, _$DiscoveryStateErrorImpl>
    implements _$$DiscoveryStateErrorImplCopyWith<$Res> {
  __$$DiscoveryStateErrorImplCopyWithImpl(_$DiscoveryStateErrorImpl _value,
      $Res Function(_$DiscoveryStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DiscoveryStateErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DiscoveryStateErrorImpl implements DiscoveryStateError {
  const _$DiscoveryStateErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'DiscoveryState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveryStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveryStateErrorImplCopyWith<_$DiscoveryStateErrorImpl> get copyWith =>
      __$$DiscoveryStateErrorImplCopyWithImpl<_$DiscoveryStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CitizenServiceModel> list) loaded,
    required TResult Function(List<CategoryModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CitizenServiceModel> list)? loaded,
    TResult? Function(List<CategoryModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CitizenServiceModel> list)? loaded,
    TResult Function(List<CategoryModel> list)? updated,
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
    required TResult Function(DiscoveryStateUpdated value) updated,
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
    TResult? Function(DiscoveryStateUpdated value)? updated,
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
    TResult Function(DiscoveryStateUpdated value)? updated,
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
  const factory DiscoveryStateError(final String error) =
      _$DiscoveryStateErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$DiscoveryStateErrorImplCopyWith<_$DiscoveryStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

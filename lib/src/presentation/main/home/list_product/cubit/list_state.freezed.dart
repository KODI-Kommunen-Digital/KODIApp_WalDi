// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListStateCopyWith<$Res> {
  factory $ListStateCopyWith(ListState value, $Res Function(ListState) then) =
      _$ListStateCopyWithImpl<$Res, ListState>;
}

/// @nodoc
class _$ListStateCopyWithImpl<$Res, $Val extends ListState>
    implements $ListStateCopyWith<$Res> {
  _$ListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ListStateInitialImplCopyWith<$Res> {
  factory _$$ListStateInitialImplCopyWith(_$ListStateInitialImpl value,
          $Res Function(_$ListStateInitialImpl) then) =
      __$$ListStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListStateInitialImplCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateInitialImpl>
    implements _$$ListStateInitialImplCopyWith<$Res> {
  __$$ListStateInitialImplCopyWithImpl(_$ListStateInitialImpl _value,
      $Res Function(_$ListStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListStateInitialImpl implements ListStateInitial {
  const _$ListStateInitialImpl();

  @override
  String toString() {
    return 'ListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
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
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ListStateInitial implements ListState {
  const factory ListStateInitial() = _$ListStateInitialImpl;
}

/// @nodoc
abstract class _$$ListStateLoadingImplCopyWith<$Res> {
  factory _$$ListStateLoadingImplCopyWith(_$ListStateLoadingImpl value,
          $Res Function(_$ListStateLoadingImpl) then) =
      __$$ListStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListStateLoadingImplCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateLoadingImpl>
    implements _$$ListStateLoadingImplCopyWith<$Res> {
  __$$ListStateLoadingImplCopyWithImpl(_$ListStateLoadingImpl _value,
      $Res Function(_$ListStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListStateLoadingImpl implements ListStateLoading {
  const _$ListStateLoadingImpl();

  @override
  String toString() {
    return 'ListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
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
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ListStateLoading implements ListState {
  const factory ListStateLoading() = _$ListStateLoadingImpl;
}

/// @nodoc
abstract class _$$ListStateLoadedImplCopyWith<$Res> {
  factory _$$ListStateLoadedImplCopyWith(_$ListStateLoadedImpl value,
          $Res Function(_$ListStateLoadedImpl) then) =
      __$$ListStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> list, List<dynamic> cityList});
}

/// @nodoc
class __$$ListStateLoadedImplCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateLoadedImpl>
    implements _$$ListStateLoadedImplCopyWith<$Res> {
  __$$ListStateLoadedImplCopyWithImpl(
      _$ListStateLoadedImpl _value, $Res Function(_$ListStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? cityList = null,
  }) {
    return _then(_$ListStateLoadedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      null == cityList
          ? _value._cityList
          : cityList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$ListStateLoadedImpl implements ListStateLoaded {
  const _$ListStateLoadedImpl(
      final List<ProductModel> list, final List<dynamic> cityList)
      : _list = list,
        _cityList = cityList;

  final List<ProductModel> _list;
  @override
  List<ProductModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<dynamic> _cityList;
  @override
  List<dynamic> get cityList {
    if (_cityList is EqualUnmodifiableListView) return _cityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cityList);
  }

  @override
  String toString() {
    return 'ListState.loaded(list: $list, cityList: $cityList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._cityList, _cityList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_cityList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateLoadedImplCopyWith<_$ListStateLoadedImpl> get copyWith =>
      __$$ListStateLoadedImplCopyWithImpl<_$ListStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) {
    return loaded(list, cityList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(list, cityList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list, cityList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ListStateLoaded implements ListState {
  const factory ListStateLoaded(
          final List<ProductModel> list, final List<dynamic> cityList) =
      _$ListStateLoadedImpl;

  List<ProductModel> get list;
  List<dynamic> get cityList;
  @JsonKey(ignore: true)
  _$$ListStateLoadedImplCopyWith<_$ListStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListStateUpdatedImplCopyWith<$Res> {
  factory _$$ListStateUpdatedImplCopyWith(_$ListStateUpdatedImpl value,
          $Res Function(_$ListStateUpdatedImpl) then) =
      __$$ListStateUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> list, List<dynamic> cityList});
}

/// @nodoc
class __$$ListStateUpdatedImplCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateUpdatedImpl>
    implements _$$ListStateUpdatedImplCopyWith<$Res> {
  __$$ListStateUpdatedImplCopyWithImpl(_$ListStateUpdatedImpl _value,
      $Res Function(_$ListStateUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? cityList = null,
  }) {
    return _then(_$ListStateUpdatedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      null == cityList
          ? _value._cityList
          : cityList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$ListStateUpdatedImpl implements ListStateUpdated {
  const _$ListStateUpdatedImpl(
      final List<ProductModel> list, final List<dynamic> cityList)
      : _list = list,
        _cityList = cityList;

  final List<ProductModel> _list;
  @override
  List<ProductModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<dynamic> _cityList;
  @override
  List<dynamic> get cityList {
    if (_cityList is EqualUnmodifiableListView) return _cityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cityList);
  }

  @override
  String toString() {
    return 'ListState.updated(list: $list, cityList: $cityList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateUpdatedImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._cityList, _cityList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_cityList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateUpdatedImplCopyWith<_$ListStateUpdatedImpl> get copyWith =>
      __$$ListStateUpdatedImplCopyWithImpl<_$ListStateUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) {
    return updated(list, cityList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) {
    return updated?.call(list, cityList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(list, cityList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class ListStateUpdated implements ListState {
  const factory ListStateUpdated(
          final List<ProductModel> list, final List<dynamic> cityList) =
      _$ListStateUpdatedImpl;

  List<ProductModel> get list;
  List<dynamic> get cityList;
  @JsonKey(ignore: true)
  _$$ListStateUpdatedImplCopyWith<_$ListStateUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListStateErrorImplCopyWith<$Res> {
  factory _$$ListStateErrorImplCopyWith(_$ListStateErrorImpl value,
          $Res Function(_$ListStateErrorImpl) then) =
      __$$ListStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ListStateErrorImplCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateErrorImpl>
    implements _$$ListStateErrorImplCopyWith<$Res> {
  __$$ListStateErrorImplCopyWithImpl(
      _$ListStateErrorImpl _value, $Res Function(_$ListStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ListStateErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ListStateErrorImpl implements ListStateError {
  const _$ListStateErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateErrorImplCopyWith<_$ListStateErrorImpl> get copyWith =>
      __$$ListStateErrorImplCopyWithImpl<_$ListStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        loaded,
    required TResult Function(List<ProductModel> list, List<dynamic> cityList)
        updated,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult? Function(List<ProductModel> list, List<dynamic> cityList)? updated,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? loaded,
    TResult Function(List<ProductModel> list, List<dynamic> cityList)? updated,
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
    required TResult Function(ListStateInitial value) initial,
    required TResult Function(ListStateLoading value) loading,
    required TResult Function(ListStateLoaded value) loaded,
    required TResult Function(ListStateUpdated value) updated,
    required TResult Function(ListStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListStateInitial value)? initial,
    TResult? Function(ListStateLoading value)? loading,
    TResult? Function(ListStateLoaded value)? loaded,
    TResult? Function(ListStateUpdated value)? updated,
    TResult? Function(ListStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListStateInitial value)? initial,
    TResult Function(ListStateLoading value)? loading,
    TResult Function(ListStateLoaded value)? loaded,
    TResult Function(ListStateUpdated value)? updated,
    TResult Function(ListStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ListStateError implements ListState {
  const factory ListStateError(final String error) = _$ListStateErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$ListStateErrorImplCopyWith<_$ListStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

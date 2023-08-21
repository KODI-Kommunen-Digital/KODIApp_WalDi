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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
abstract class _$$ListStateInitialCopyWith<$Res> {
  factory _$$ListStateInitialCopyWith(
          _$ListStateInitial value, $Res Function(_$ListStateInitial) then) =
      __$$ListStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListStateInitialCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateInitial>
    implements _$$ListStateInitialCopyWith<$Res> {
  __$$ListStateInitialCopyWithImpl(
      _$ListStateInitial _value, $Res Function(_$ListStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListStateInitial implements ListStateInitial {
  const _$ListStateInitial();

  @override
  String toString() {
    return 'ListState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
  const factory ListStateInitial() = _$ListStateInitial;
}

/// @nodoc
abstract class _$$ListStateLoadingCopyWith<$Res> {
  factory _$$ListStateLoadingCopyWith(
          _$ListStateLoading value, $Res Function(_$ListStateLoading) then) =
      __$$ListStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListStateLoadingCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateLoading>
    implements _$$ListStateLoadingCopyWith<$Res> {
  __$$ListStateLoadingCopyWithImpl(
      _$ListStateLoading _value, $Res Function(_$ListStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListStateLoading implements ListStateLoading {
  const _$ListStateLoading();

  @override
  String toString() {
    return 'ListState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
  const factory ListStateLoading() = _$ListStateLoading;
}

/// @nodoc
abstract class _$$ListStateLoadedCopyWith<$Res> {
  factory _$$ListStateLoadedCopyWith(
          _$ListStateLoaded value, $Res Function(_$ListStateLoaded) then) =
      __$$ListStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> list});
}

/// @nodoc
class __$$ListStateLoadedCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateLoaded>
    implements _$$ListStateLoadedCopyWith<$Res> {
  __$$ListStateLoadedCopyWithImpl(
      _$ListStateLoaded _value, $Res Function(_$ListStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ListStateLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$ListStateLoaded implements ListStateLoaded {
  const _$ListStateLoaded(final List<ProductModel> list) : _list = list;

  final List<ProductModel> _list;
  @override
  List<ProductModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'ListState.loaded(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateLoadedCopyWith<_$ListStateLoaded> get copyWith =>
      __$$ListStateLoadedCopyWithImpl<_$ListStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
  const factory ListStateLoaded(final List<ProductModel> list) =
      _$ListStateLoaded;

  List<ProductModel> get list;
  @JsonKey(ignore: true)
  _$$ListStateLoadedCopyWith<_$ListStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListStateUpdatedCopyWith<$Res> {
  factory _$$ListStateUpdatedCopyWith(
          _$ListStateUpdated value, $Res Function(_$ListStateUpdated) then) =
      __$$ListStateUpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> list});
}

/// @nodoc
class __$$ListStateUpdatedCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateUpdated>
    implements _$$ListStateUpdatedCopyWith<$Res> {
  __$$ListStateUpdatedCopyWithImpl(
      _$ListStateUpdated _value, $Res Function(_$ListStateUpdated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ListStateUpdated(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

class _$ListStateUpdated implements ListStateUpdated {
  const _$ListStateUpdated(final List<ProductModel> list) : _list = list;

  final List<ProductModel> _list;
  @override
  List<ProductModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'ListState.updated(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateUpdated &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateUpdatedCopyWith<_$ListStateUpdated> get copyWith =>
      __$$ListStateUpdatedCopyWithImpl<_$ListStateUpdated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return updated(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return updated?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
  const factory ListStateUpdated(final List<ProductModel> list) =
      _$ListStateUpdated;

  List<ProductModel> get list;
  @JsonKey(ignore: true)
  _$$ListStateUpdatedCopyWith<_$ListStateUpdated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListStateErrorCopyWith<$Res> {
  factory _$$ListStateErrorCopyWith(
          _$ListStateError value, $Res Function(_$ListStateError) then) =
      __$$ListStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ListStateErrorCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$ListStateError>
    implements _$$ListStateErrorCopyWith<$Res> {
  __$$ListStateErrorCopyWithImpl(
      _$ListStateError _value, $Res Function(_$ListStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ListStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ListStateError implements ListStateError {
  const _$ListStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ListState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListStateErrorCopyWith<_$ListStateError> get copyWith =>
      __$$ListStateErrorCopyWithImpl<_$ListStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> list) loaded,
    required TResult Function(List<ProductModel> list) updated,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> list)? loaded,
    TResult? Function(List<ProductModel> list)? updated,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> list)? loaded,
    TResult Function(List<ProductModel> list)? updated,
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
  const factory ListStateError(final String error) = _$ListStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$ListStateErrorCopyWith<_$ListStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

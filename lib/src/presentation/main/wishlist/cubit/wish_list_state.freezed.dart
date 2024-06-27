// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WishListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteDetailsModel> favorites) loaded,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult? Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WishListInitial value) initial,
    required TResult Function(WishListLoading value) loading,
    required TResult Function(WishListLoaded value) loaded,
    required TResult Function(WishListError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WishListInitial value)? initial,
    TResult? Function(WishListLoading value)? loading,
    TResult? Function(WishListLoaded value)? loaded,
    TResult? Function(WishListError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishListInitial value)? initial,
    TResult Function(WishListLoading value)? loading,
    TResult Function(WishListLoaded value)? loaded,
    TResult Function(WishListError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishListStateCopyWith<$Res> {
  factory $WishListStateCopyWith(
          WishListState value, $Res Function(WishListState) then) =
      _$WishListStateCopyWithImpl<$Res, WishListState>;
}

/// @nodoc
class _$WishListStateCopyWithImpl<$Res, $Val extends WishListState>
    implements $WishListStateCopyWith<$Res> {
  _$WishListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WishListInitialImplCopyWith<$Res> {
  factory _$$WishListInitialImplCopyWith(_$WishListInitialImpl value,
          $Res Function(_$WishListInitialImpl) then) =
      __$$WishListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WishListInitialImplCopyWithImpl<$Res>
    extends _$WishListStateCopyWithImpl<$Res, _$WishListInitialImpl>
    implements _$$WishListInitialImplCopyWith<$Res> {
  __$$WishListInitialImplCopyWithImpl(
      _$WishListInitialImpl _value, $Res Function(_$WishListInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WishListInitialImpl implements WishListInitial {
  const _$WishListInitialImpl();

  @override
  String toString() {
    return 'WishListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WishListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteDetailsModel> favorites) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteDetailsModel> favorites)? loaded,
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
    required TResult Function(WishListInitial value) initial,
    required TResult Function(WishListLoading value) loading,
    required TResult Function(WishListLoaded value) loaded,
    required TResult Function(WishListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WishListInitial value)? initial,
    TResult? Function(WishListLoading value)? loading,
    TResult? Function(WishListLoaded value)? loaded,
    TResult? Function(WishListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishListInitial value)? initial,
    TResult Function(WishListLoading value)? loading,
    TResult Function(WishListLoaded value)? loaded,
    TResult Function(WishListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class WishListInitial implements WishListState {
  const factory WishListInitial() = _$WishListInitialImpl;
}

/// @nodoc
abstract class _$$WishListLoadingImplCopyWith<$Res> {
  factory _$$WishListLoadingImplCopyWith(_$WishListLoadingImpl value,
          $Res Function(_$WishListLoadingImpl) then) =
      __$$WishListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WishListLoadingImplCopyWithImpl<$Res>
    extends _$WishListStateCopyWithImpl<$Res, _$WishListLoadingImpl>
    implements _$$WishListLoadingImplCopyWith<$Res> {
  __$$WishListLoadingImplCopyWithImpl(
      _$WishListLoadingImpl _value, $Res Function(_$WishListLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WishListLoadingImpl implements WishListLoading {
  const _$WishListLoadingImpl();

  @override
  String toString() {
    return 'WishListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WishListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteDetailsModel> favorites) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteDetailsModel> favorites)? loaded,
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
    required TResult Function(WishListInitial value) initial,
    required TResult Function(WishListLoading value) loading,
    required TResult Function(WishListLoaded value) loaded,
    required TResult Function(WishListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WishListInitial value)? initial,
    TResult? Function(WishListLoading value)? loading,
    TResult? Function(WishListLoaded value)? loaded,
    TResult? Function(WishListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishListInitial value)? initial,
    TResult Function(WishListLoading value)? loading,
    TResult Function(WishListLoaded value)? loaded,
    TResult Function(WishListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WishListLoading implements WishListState {
  const factory WishListLoading() = _$WishListLoadingImpl;
}

/// @nodoc
abstract class _$$WishListLoadedImplCopyWith<$Res> {
  factory _$$WishListLoadedImplCopyWith(_$WishListLoadedImpl value,
          $Res Function(_$WishListLoadedImpl) then) =
      __$$WishListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FavoriteDetailsModel> favorites});
}

/// @nodoc
class __$$WishListLoadedImplCopyWithImpl<$Res>
    extends _$WishListStateCopyWithImpl<$Res, _$WishListLoadedImpl>
    implements _$$WishListLoadedImplCopyWith<$Res> {
  __$$WishListLoadedImplCopyWithImpl(
      _$WishListLoadedImpl _value, $Res Function(_$WishListLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
  }) {
    return _then(_$WishListLoadedImpl(
      null == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<FavoriteDetailsModel>,
    ));
  }
}

/// @nodoc

class _$WishListLoadedImpl implements WishListLoaded {
  const _$WishListLoadedImpl(final List<FavoriteDetailsModel> favorites)
      : _favorites = favorites;

  final List<FavoriteDetailsModel> _favorites;
  @override
  List<FavoriteDetailsModel> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  String toString() {
    return 'WishListState.loaded(favorites: $favorites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishListLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_favorites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WishListLoadedImplCopyWith<_$WishListLoadedImpl> get copyWith =>
      __$$WishListLoadedImplCopyWithImpl<_$WishListLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteDetailsModel> favorites) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded(favorites);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loaded?.call(favorites);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(favorites);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WishListInitial value) initial,
    required TResult Function(WishListLoading value) loading,
    required TResult Function(WishListLoaded value) loaded,
    required TResult Function(WishListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WishListInitial value)? initial,
    TResult? Function(WishListLoading value)? loading,
    TResult? Function(WishListLoaded value)? loaded,
    TResult? Function(WishListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishListInitial value)? initial,
    TResult Function(WishListLoading value)? loading,
    TResult Function(WishListLoaded value)? loaded,
    TResult Function(WishListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WishListLoaded implements WishListState {
  const factory WishListLoaded(final List<FavoriteDetailsModel> favorites) =
      _$WishListLoadedImpl;

  List<FavoriteDetailsModel> get favorites;
  @JsonKey(ignore: true)
  _$$WishListLoadedImplCopyWith<_$WishListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WishListErrorImplCopyWith<$Res> {
  factory _$$WishListErrorImplCopyWith(
          _$WishListErrorImpl value, $Res Function(_$WishListErrorImpl) then) =
      __$$WishListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$WishListErrorImplCopyWithImpl<$Res>
    extends _$WishListStateCopyWithImpl<$Res, _$WishListErrorImpl>
    implements _$$WishListErrorImplCopyWith<$Res> {
  __$$WishListErrorImplCopyWithImpl(
      _$WishListErrorImpl _value, $Res Function(_$WishListErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$WishListErrorImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WishListErrorImpl implements WishListError {
  const _$WishListErrorImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'WishListState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishListErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WishListErrorImplCopyWith<_$WishListErrorImpl> get copyWith =>
      __$$WishListErrorImplCopyWithImpl<_$WishListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteDetailsModel> favorites) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteDetailsModel> favorites)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteDetailsModel> favorites)? loaded,
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
    required TResult Function(WishListInitial value) initial,
    required TResult Function(WishListLoading value) loading,
    required TResult Function(WishListLoaded value) loaded,
    required TResult Function(WishListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WishListInitial value)? initial,
    TResult? Function(WishListLoading value)? loading,
    TResult? Function(WishListLoaded value)? loaded,
    TResult? Function(WishListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishListInitial value)? initial,
    TResult Function(WishListLoading value)? loading,
    TResult Function(WishListLoaded value)? loaded,
    TResult Function(WishListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WishListError implements WishListState {
  const factory WishListError(final String errorMessage) = _$WishListErrorImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$WishListErrorImplCopyWith<_$WishListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

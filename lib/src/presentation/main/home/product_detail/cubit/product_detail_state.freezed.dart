// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProductModel product,
            List<FavoriteModel>? favoritesList, bool isLoggedIn)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductDetailInitial value) initial,
    required TResult Function(ProductDetailLoading value) loading,
    required TResult Function(ProductDetailLoaded value) loaded,
    required TResult Function(ProductDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductDetailInitial value)? initial,
    TResult? Function(ProductDetailLoading value)? loading,
    TResult? Function(ProductDetailLoaded value)? loaded,
    TResult? Function(ProductDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductDetailInitial value)? initial,
    TResult Function(ProductDetailLoading value)? loading,
    TResult Function(ProductDetailLoaded value)? loaded,
    TResult Function(ProductDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
          ProductDetailState value, $Res Function(ProductDetailState) then) =
      _$ProductDetailStateCopyWithImpl<$Res, ProductDetailState>;
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res, $Val extends ProductDetailState>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ProductDetailInitialCopyWith<$Res> {
  factory _$$ProductDetailInitialCopyWith(_$ProductDetailInitial value,
          $Res Function(_$ProductDetailInitial) then) =
      __$$ProductDetailInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductDetailInitialCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailInitial>
    implements _$$ProductDetailInitialCopyWith<$Res> {
  __$$ProductDetailInitialCopyWithImpl(_$ProductDetailInitial _value,
      $Res Function(_$ProductDetailInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProductDetailInitial implements ProductDetailInitial {
  const _$ProductDetailInitial();

  @override
  String toString() {
    return 'ProductDetailState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductDetailInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProductModel product,
            List<FavoriteModel>? favoritesList, bool isLoggedIn)
        loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
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
    required TResult Function(ProductDetailInitial value) initial,
    required TResult Function(ProductDetailLoading value) loading,
    required TResult Function(ProductDetailLoaded value) loaded,
    required TResult Function(ProductDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductDetailInitial value)? initial,
    TResult? Function(ProductDetailLoading value)? loading,
    TResult? Function(ProductDetailLoaded value)? loaded,
    TResult? Function(ProductDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductDetailInitial value)? initial,
    TResult Function(ProductDetailLoading value)? loading,
    TResult Function(ProductDetailLoaded value)? loaded,
    TResult Function(ProductDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProductDetailInitial implements ProductDetailState {
  const factory ProductDetailInitial() = _$ProductDetailInitial;
}

/// @nodoc
abstract class _$$ProductDetailLoadingCopyWith<$Res> {
  factory _$$ProductDetailLoadingCopyWith(_$ProductDetailLoading value,
          $Res Function(_$ProductDetailLoading) then) =
      __$$ProductDetailLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductDetailLoadingCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailLoading>
    implements _$$ProductDetailLoadingCopyWith<$Res> {
  __$$ProductDetailLoadingCopyWithImpl(_$ProductDetailLoading _value,
      $Res Function(_$ProductDetailLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProductDetailLoading implements ProductDetailLoading {
  const _$ProductDetailLoading();

  @override
  String toString() {
    return 'ProductDetailState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductDetailLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProductModel product,
            List<FavoriteModel>? favoritesList, bool isLoggedIn)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
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
    required TResult Function(ProductDetailInitial value) initial,
    required TResult Function(ProductDetailLoading value) loading,
    required TResult Function(ProductDetailLoaded value) loaded,
    required TResult Function(ProductDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductDetailInitial value)? initial,
    TResult? Function(ProductDetailLoading value)? loading,
    TResult? Function(ProductDetailLoaded value)? loaded,
    TResult? Function(ProductDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductDetailInitial value)? initial,
    TResult Function(ProductDetailLoading value)? loading,
    TResult Function(ProductDetailLoaded value)? loaded,
    TResult Function(ProductDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProductDetailLoading implements ProductDetailState {
  const factory ProductDetailLoading() = _$ProductDetailLoading;
}

/// @nodoc
abstract class _$$ProductDetailLoadedCopyWith<$Res> {
  factory _$$ProductDetailLoadedCopyWith(_$ProductDetailLoaded value,
          $Res Function(_$ProductDetailLoaded) then) =
      __$$ProductDetailLoadedCopyWithImpl<$Res>;

  @useResult
  $Res call(
      {ProductModel product,
      List<FavoriteModel>? favoritesList,
      bool isLoggedIn});
}

/// @nodoc
class __$$ProductDetailLoadedCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailLoaded>
    implements _$$ProductDetailLoadedCopyWith<$Res> {
  __$$ProductDetailLoadedCopyWithImpl(
      _$ProductDetailLoaded _value, $Res Function(_$ProductDetailLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? favoritesList = freezed,
    Object? isLoggedIn = null,
  }) {
    return _then(_$ProductDetailLoaded(
      null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      freezed == favoritesList
          ? _value._favoritesList
          : favoritesList // ignore: cast_nullable_to_non_nullable
              as List<FavoriteModel>?,
      null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProductDetailLoaded implements ProductDetailLoaded {
  const _$ProductDetailLoaded(
      this.product, final List<FavoriteModel>? favoritesList, this.isLoggedIn)
      : _favoritesList = favoritesList;

  @override
  final ProductModel product;
  final List<FavoriteModel>? _favoritesList;

  @override
  List<FavoriteModel>? get favoritesList {
    final value = _favoritesList;
    if (value == null) return null;
    if (_favoritesList is EqualUnmodifiableListView) return _favoritesList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isLoggedIn;

  @override
  String toString() {
    return 'ProductDetailState.loaded(product: $product, favoritesList: $favoritesList, isLoggedIn: $isLoggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailLoaded &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other._favoritesList, _favoritesList) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product,
      const DeepCollectionEquality().hash(_favoritesList), isLoggedIn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailLoadedCopyWith<_$ProductDetailLoaded> get copyWith =>
      __$$ProductDetailLoadedCopyWithImpl<_$ProductDetailLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProductModel product,
            List<FavoriteModel>? favoritesList, bool isLoggedIn)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(product, favoritesList, isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(product, favoritesList, isLoggedIn);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(product, favoritesList, isLoggedIn);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductDetailInitial value) initial,
    required TResult Function(ProductDetailLoading value) loading,
    required TResult Function(ProductDetailLoaded value) loaded,
    required TResult Function(ProductDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductDetailInitial value)? initial,
    TResult? Function(ProductDetailLoading value)? loading,
    TResult? Function(ProductDetailLoaded value)? loaded,
    TResult? Function(ProductDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductDetailInitial value)? initial,
    TResult Function(ProductDetailLoading value)? loading,
    TResult Function(ProductDetailLoaded value)? loaded,
    TResult Function(ProductDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProductDetailLoaded implements ProductDetailState {
  const factory ProductDetailLoaded(
      final ProductModel product,
      final List<FavoriteModel>? favoritesList,
      final bool isLoggedIn) = _$ProductDetailLoaded;

  ProductModel get product;

  List<FavoriteModel>? get favoritesList;

  bool get isLoggedIn;

  @JsonKey(ignore: true)
  _$$ProductDetailLoadedCopyWith<_$ProductDetailLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProductDetailErrorCopyWith<$Res> {
  factory _$$ProductDetailErrorCopyWith(_$ProductDetailError value,
          $Res Function(_$ProductDetailError) then) =
      __$$ProductDetailErrorCopyWithImpl<$Res>;

  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ProductDetailErrorCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailError>
    implements _$$ProductDetailErrorCopyWith<$Res> {
  __$$ProductDetailErrorCopyWithImpl(
      _$ProductDetailError _value, $Res Function(_$ProductDetailError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ProductDetailError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProductDetailError implements ProductDetailError {
  const _$ProductDetailError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ProductDetailState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailErrorCopyWith<_$ProductDetailError> get copyWith =>
      __$$ProductDetailErrorCopyWithImpl<_$ProductDetailError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProductModel product,
            List<FavoriteModel>? favoritesList, bool isLoggedIn)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProductModel product, List<FavoriteModel>? favoritesList,
            bool isLoggedIn)?
        loaded,
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
    required TResult Function(ProductDetailInitial value) initial,
    required TResult Function(ProductDetailLoading value) loading,
    required TResult Function(ProductDetailLoaded value) loaded,
    required TResult Function(ProductDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductDetailInitial value)? initial,
    TResult? Function(ProductDetailLoading value)? loading,
    TResult? Function(ProductDetailLoaded value)? loaded,
    TResult? Function(ProductDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductDetailInitial value)? initial,
    TResult Function(ProductDetailLoading value)? loading,
    TResult Function(ProductDetailLoaded value)? loaded,
    TResult Function(ProductDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProductDetailError implements ProductDetailState {
  const factory ProductDetailError(final String error) = _$ProductDetailError;

  String get error;

  @JsonKey(ignore: true)
  _$$ProductDetailErrorCopyWith<_$ProductDetailError> get copyWith =>
      throw _privateConstructorUsedError;
}

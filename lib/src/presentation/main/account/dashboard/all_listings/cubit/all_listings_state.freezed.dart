// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_listings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllListingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> recent, int currentFilter, int currentCityFilter)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllListingsStateInitial value) initial,
    required TResult Function(AllListingsStateLoading value) loading,
    required TResult Function(AllListingsStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllListingsStateInitial value)? initial,
    TResult? Function(AllListingsStateLoading value)? loading,
    TResult? Function(AllListingsStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllListingsStateInitial value)? initial,
    TResult Function(AllListingsStateLoading value)? loading,
    TResult Function(AllListingsStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllListingsStateCopyWith<$Res> {
  factory $AllListingsStateCopyWith(
          AllListingsState value, $Res Function(AllListingsState) then) =
      _$AllListingsStateCopyWithImpl<$Res, AllListingsState>;
}

/// @nodoc
class _$AllListingsStateCopyWithImpl<$Res, $Val extends AllListingsState>
    implements $AllListingsStateCopyWith<$Res> {
  _$AllListingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AllListingsStateInitialImplCopyWith<$Res> {
  factory _$$AllListingsStateInitialImplCopyWith(
          _$AllListingsStateInitialImpl value,
          $Res Function(_$AllListingsStateInitialImpl) then) =
      __$$AllListingsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllListingsStateInitialImplCopyWithImpl<$Res>
    extends _$AllListingsStateCopyWithImpl<$Res, _$AllListingsStateInitialImpl>
    implements _$$AllListingsStateInitialImplCopyWith<$Res> {
  __$$AllListingsStateInitialImplCopyWithImpl(
      _$AllListingsStateInitialImpl _value,
      $Res Function(_$AllListingsStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AllListingsStateInitialImpl implements AllListingsStateInitial {
  const _$AllListingsStateInitialImpl();

  @override
  String toString() {
    return 'AllListingsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllListingsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> recent, int currentFilter, int currentCityFilter)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
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
    required TResult Function(AllListingsStateInitial value) initial,
    required TResult Function(AllListingsStateLoading value) loading,
    required TResult Function(AllListingsStateLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllListingsStateInitial value)? initial,
    TResult? Function(AllListingsStateLoading value)? loading,
    TResult? Function(AllListingsStateLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllListingsStateInitial value)? initial,
    TResult Function(AllListingsStateLoading value)? loading,
    TResult Function(AllListingsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AllListingsStateInitial implements AllListingsState {
  const factory AllListingsStateInitial() = _$AllListingsStateInitialImpl;
}

/// @nodoc
abstract class _$$AllListingsStateLoadingImplCopyWith<$Res> {
  factory _$$AllListingsStateLoadingImplCopyWith(
          _$AllListingsStateLoadingImpl value,
          $Res Function(_$AllListingsStateLoadingImpl) then) =
      __$$AllListingsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllListingsStateLoadingImplCopyWithImpl<$Res>
    extends _$AllListingsStateCopyWithImpl<$Res, _$AllListingsStateLoadingImpl>
    implements _$$AllListingsStateLoadingImplCopyWith<$Res> {
  __$$AllListingsStateLoadingImplCopyWithImpl(
      _$AllListingsStateLoadingImpl _value,
      $Res Function(_$AllListingsStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AllListingsStateLoadingImpl implements AllListingsStateLoading {
  const _$AllListingsStateLoadingImpl();

  @override
  String toString() {
    return 'AllListingsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllListingsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> recent, int currentFilter, int currentCityFilter)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
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
    required TResult Function(AllListingsStateInitial value) initial,
    required TResult Function(AllListingsStateLoading value) loading,
    required TResult Function(AllListingsStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllListingsStateInitial value)? initial,
    TResult? Function(AllListingsStateLoading value)? loading,
    TResult? Function(AllListingsStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllListingsStateInitial value)? initial,
    TResult Function(AllListingsStateLoading value)? loading,
    TResult Function(AllListingsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AllListingsStateLoading implements AllListingsState {
  const factory AllListingsStateLoading() = _$AllListingsStateLoadingImpl;
}

/// @nodoc
abstract class _$$AllListingsStateLoadedImplCopyWith<$Res> {
  factory _$$AllListingsStateLoadedImplCopyWith(
          _$AllListingsStateLoadedImpl value,
          $Res Function(_$AllListingsStateLoadedImpl) then) =
      __$$AllListingsStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ProductModel> recent, int currentFilter, int currentCityFilter});
}

/// @nodoc
class __$$AllListingsStateLoadedImplCopyWithImpl<$Res>
    extends _$AllListingsStateCopyWithImpl<$Res, _$AllListingsStateLoadedImpl>
    implements _$$AllListingsStateLoadedImplCopyWith<$Res> {
  __$$AllListingsStateLoadedImplCopyWithImpl(
      _$AllListingsStateLoadedImpl _value,
      $Res Function(_$AllListingsStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = null,
    Object? currentFilter = null,
    Object? currentCityFilter = null,
  }) {
    return _then(_$AllListingsStateLoadedImpl(
      null == recent
          ? _value._recent
          : recent // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      null == currentFilter
          ? _value.currentFilter
          : currentFilter // ignore: cast_nullable_to_non_nullable
              as int,
      null == currentCityFilter
          ? _value.currentCityFilter
          : currentCityFilter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AllListingsStateLoadedImpl implements AllListingsStateLoaded {
  const _$AllListingsStateLoadedImpl(final List<ProductModel> recent,
      this.currentFilter, this.currentCityFilter)
      : _recent = recent;

  final List<ProductModel> _recent;
  @override
  List<ProductModel> get recent {
    if (_recent is EqualUnmodifiableListView) return _recent;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recent);
  }

  @override
  final int currentFilter;
  @override
  final int currentCityFilter;

  @override
  String toString() {
    return 'AllListingsState.loaded(recent: $recent, currentFilter: $currentFilter, currentCityFilter: $currentCityFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllListingsStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._recent, _recent) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.currentCityFilter, currentCityFilter) ||
                other.currentCityFilter == currentCityFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recent),
      currentFilter,
      currentCityFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllListingsStateLoadedImplCopyWith<_$AllListingsStateLoadedImpl>
      get copyWith => __$$AllListingsStateLoadedImplCopyWithImpl<
          _$AllListingsStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> recent, int currentFilter, int currentCityFilter)
        loaded,
  }) {
    return loaded(recent, currentFilter, currentCityFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
  }) {
    return loaded?.call(recent, currentFilter, currentCityFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, int currentFilter,
            int currentCityFilter)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(recent, currentFilter, currentCityFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllListingsStateInitial value) initial,
    required TResult Function(AllListingsStateLoading value) loading,
    required TResult Function(AllListingsStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllListingsStateInitial value)? initial,
    TResult? Function(AllListingsStateLoading value)? loading,
    TResult? Function(AllListingsStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllListingsStateInitial value)? initial,
    TResult Function(AllListingsStateLoading value)? loading,
    TResult Function(AllListingsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AllListingsStateLoaded implements AllListingsState {
  const factory AllListingsStateLoaded(
      final List<ProductModel> recent,
      final int currentFilter,
      final int currentCityFilter) = _$AllListingsStateLoadedImpl;

  List<ProductModel> get recent;
  int get currentFilter;
  int get currentCityFilter;
  @JsonKey(ignore: true)
  _$$AllListingsStateLoadedImplCopyWith<_$AllListingsStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

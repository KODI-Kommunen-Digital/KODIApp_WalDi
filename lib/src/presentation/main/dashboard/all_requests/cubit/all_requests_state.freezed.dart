// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllRequestsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> recent, bool isRefreshLoader)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllRequestsStateInitial value) initial,
    required TResult Function(AllRequestsStateLoading value) loading,
    required TResult Function(AllRequestsStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllRequestsStateInitial value)? initial,
    TResult? Function(AllRequestsStateLoading value)? loading,
    TResult? Function(AllRequestsStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllRequestsStateInitial value)? initial,
    TResult Function(AllRequestsStateLoading value)? loading,
    TResult Function(AllRequestsStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllRequestsStateCopyWith<$Res> {
  factory $AllRequestsStateCopyWith(
          AllRequestsState value, $Res Function(AllRequestsState) then) =
      _$AllRequestsStateCopyWithImpl<$Res, AllRequestsState>;
}

/// @nodoc
class _$AllRequestsStateCopyWithImpl<$Res, $Val extends AllRequestsState>
    implements $AllRequestsStateCopyWith<$Res> {
  _$AllRequestsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AllRequestsStateInitialImplCopyWith<$Res> {
  factory _$$AllRequestsStateInitialImplCopyWith(
          _$AllRequestsStateInitialImpl value,
          $Res Function(_$AllRequestsStateInitialImpl) then) =
      __$$AllRequestsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllRequestsStateInitialImplCopyWithImpl<$Res>
    extends _$AllRequestsStateCopyWithImpl<$Res, _$AllRequestsStateInitialImpl>
    implements _$$AllRequestsStateInitialImplCopyWith<$Res> {
  __$$AllRequestsStateInitialImplCopyWithImpl(
      _$AllRequestsStateInitialImpl _value,
      $Res Function(_$AllRequestsStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AllRequestsStateInitialImpl implements AllRequestsStateInitial {
  const _$AllRequestsStateInitialImpl();

  @override
  String toString() {
    return 'AllRequestsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllRequestsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> recent, bool isRefreshLoader)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
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
    required TResult Function(AllRequestsStateInitial value) initial,
    required TResult Function(AllRequestsStateLoading value) loading,
    required TResult Function(AllRequestsStateLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllRequestsStateInitial value)? initial,
    TResult? Function(AllRequestsStateLoading value)? loading,
    TResult? Function(AllRequestsStateLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllRequestsStateInitial value)? initial,
    TResult Function(AllRequestsStateLoading value)? loading,
    TResult Function(AllRequestsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AllRequestsStateInitial implements AllRequestsState {
  const factory AllRequestsStateInitial() = _$AllRequestsStateInitialImpl;
}

/// @nodoc
abstract class _$$AllRequestsStateLoadingImplCopyWith<$Res> {
  factory _$$AllRequestsStateLoadingImplCopyWith(
          _$AllRequestsStateLoadingImpl value,
          $Res Function(_$AllRequestsStateLoadingImpl) then) =
      __$$AllRequestsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllRequestsStateLoadingImplCopyWithImpl<$Res>
    extends _$AllRequestsStateCopyWithImpl<$Res, _$AllRequestsStateLoadingImpl>
    implements _$$AllRequestsStateLoadingImplCopyWith<$Res> {
  __$$AllRequestsStateLoadingImplCopyWithImpl(
      _$AllRequestsStateLoadingImpl _value,
      $Res Function(_$AllRequestsStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AllRequestsStateLoadingImpl implements AllRequestsStateLoading {
  const _$AllRequestsStateLoadingImpl();

  @override
  String toString() {
    return 'AllRequestsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllRequestsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> recent, bool isRefreshLoader)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
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
    required TResult Function(AllRequestsStateInitial value) initial,
    required TResult Function(AllRequestsStateLoading value) loading,
    required TResult Function(AllRequestsStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllRequestsStateInitial value)? initial,
    TResult? Function(AllRequestsStateLoading value)? loading,
    TResult? Function(AllRequestsStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllRequestsStateInitial value)? initial,
    TResult Function(AllRequestsStateLoading value)? loading,
    TResult Function(AllRequestsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AllRequestsStateLoading implements AllRequestsState {
  const factory AllRequestsStateLoading() = _$AllRequestsStateLoadingImpl;
}

/// @nodoc
abstract class _$$AllRequestsStateLoadedImplCopyWith<$Res> {
  factory _$$AllRequestsStateLoadedImplCopyWith(
          _$AllRequestsStateLoadedImpl value,
          $Res Function(_$AllRequestsStateLoadedImpl) then) =
      __$$AllRequestsStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductModel> recent, bool isRefreshLoader});
}

/// @nodoc
class __$$AllRequestsStateLoadedImplCopyWithImpl<$Res>
    extends _$AllRequestsStateCopyWithImpl<$Res, _$AllRequestsStateLoadedImpl>
    implements _$$AllRequestsStateLoadedImplCopyWith<$Res> {
  __$$AllRequestsStateLoadedImplCopyWithImpl(
      _$AllRequestsStateLoadedImpl _value,
      $Res Function(_$AllRequestsStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = null,
    Object? isRefreshLoader = null,
  }) {
    return _then(_$AllRequestsStateLoadedImpl(
      null == recent
          ? _value._recent
          : recent // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      null == isRefreshLoader
          ? _value.isRefreshLoader
          : isRefreshLoader // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AllRequestsStateLoadedImpl implements AllRequestsStateLoaded {
  const _$AllRequestsStateLoadedImpl(
      final List<ProductModel> recent, this.isRefreshLoader)
      : _recent = recent;

  final List<ProductModel> _recent;
  @override
  List<ProductModel> get recent {
    if (_recent is EqualUnmodifiableListView) return _recent;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recent);
  }

  @override
  final bool isRefreshLoader;

  @override
  String toString() {
    return 'AllRequestsState.loaded(recent: $recent, isRefreshLoader: $isRefreshLoader)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllRequestsStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._recent, _recent) &&
            (identical(other.isRefreshLoader, isRefreshLoader) ||
                other.isRefreshLoader == isRefreshLoader));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_recent), isRefreshLoader);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllRequestsStateLoadedImplCopyWith<_$AllRequestsStateLoadedImpl>
      get copyWith => __$$AllRequestsStateLoadedImplCopyWithImpl<
          _$AllRequestsStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ProductModel> recent, bool isRefreshLoader)
        loaded,
  }) {
    return loaded(recent, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
  }) {
    return loaded?.call(recent, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ProductModel> recent, bool isRefreshLoader)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(recent, isRefreshLoader);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllRequestsStateInitial value) initial,
    required TResult Function(AllRequestsStateLoading value) loading,
    required TResult Function(AllRequestsStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllRequestsStateInitial value)? initial,
    TResult? Function(AllRequestsStateLoading value)? loading,
    TResult? Function(AllRequestsStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllRequestsStateInitial value)? initial,
    TResult Function(AllRequestsStateLoading value)? loading,
    TResult Function(AllRequestsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AllRequestsStateLoaded implements AllRequestsState {
  const factory AllRequestsStateLoaded(
          final List<ProductModel> recent, final bool isRefreshLoader) =
      _$AllRequestsStateLoadedImpl;

  List<ProductModel> get recent;
  bool get isRefreshLoader;
  @JsonKey(ignore: true)
  _$$AllRequestsStateLoadedImplCopyWith<_$AllRequestsStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

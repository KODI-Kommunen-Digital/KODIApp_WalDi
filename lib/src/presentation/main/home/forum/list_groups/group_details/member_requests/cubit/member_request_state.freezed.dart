// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MemberRequestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberRequestModel> list) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberRequestModel> list)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberRequestModel> list)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MemberRequestStateInitial value) initial,
    required TResult Function(MemberRequestLoading value) loading,
    required TResult Function(MemberRequestLoaded value) loaded,
    required TResult Function(MemberRequestError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemberRequestStateInitial value)? initial,
    TResult? Function(MemberRequestLoading value)? loading,
    TResult? Function(MemberRequestLoaded value)? loaded,
    TResult? Function(MemberRequestError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemberRequestStateInitial value)? initial,
    TResult Function(MemberRequestLoading value)? loading,
    TResult Function(MemberRequestLoaded value)? loaded,
    TResult Function(MemberRequestError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberRequestStateCopyWith<$Res> {
  factory $MemberRequestStateCopyWith(
          MemberRequestState value, $Res Function(MemberRequestState) then) =
      _$MemberRequestStateCopyWithImpl<$Res, MemberRequestState>;
}

/// @nodoc
class _$MemberRequestStateCopyWithImpl<$Res, $Val extends MemberRequestState>
    implements $MemberRequestStateCopyWith<$Res> {
  _$MemberRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MemberRequestStateInitialImplCopyWith<$Res> {
  factory _$$MemberRequestStateInitialImplCopyWith(
          _$MemberRequestStateInitialImpl value,
          $Res Function(_$MemberRequestStateInitialImpl) then) =
      __$$MemberRequestStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemberRequestStateInitialImplCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res,
        _$MemberRequestStateInitialImpl>
    implements _$$MemberRequestStateInitialImplCopyWith<$Res> {
  __$$MemberRequestStateInitialImplCopyWithImpl(
      _$MemberRequestStateInitialImpl _value,
      $Res Function(_$MemberRequestStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MemberRequestStateInitialImpl implements MemberRequestStateInitial {
  const _$MemberRequestStateInitialImpl();

  @override
  String toString() {
    return 'MemberRequestState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberRequestModel> list) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberRequestModel> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberRequestModel> list)? loaded,
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
    required TResult Function(MemberRequestStateInitial value) initial,
    required TResult Function(MemberRequestLoading value) loading,
    required TResult Function(MemberRequestLoaded value) loaded,
    required TResult Function(MemberRequestError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemberRequestStateInitial value)? initial,
    TResult? Function(MemberRequestLoading value)? loading,
    TResult? Function(MemberRequestLoaded value)? loaded,
    TResult? Function(MemberRequestError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemberRequestStateInitial value)? initial,
    TResult Function(MemberRequestLoading value)? loading,
    TResult Function(MemberRequestLoaded value)? loaded,
    TResult Function(MemberRequestError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MemberRequestStateInitial implements MemberRequestState {
  const factory MemberRequestStateInitial() = _$MemberRequestStateInitialImpl;
}

/// @nodoc
abstract class _$$MemberRequestLoadingImplCopyWith<$Res> {
  factory _$$MemberRequestLoadingImplCopyWith(_$MemberRequestLoadingImpl value,
          $Res Function(_$MemberRequestLoadingImpl) then) =
      __$$MemberRequestLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemberRequestLoadingImplCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestLoadingImpl>
    implements _$$MemberRequestLoadingImplCopyWith<$Res> {
  __$$MemberRequestLoadingImplCopyWithImpl(_$MemberRequestLoadingImpl _value,
      $Res Function(_$MemberRequestLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MemberRequestLoadingImpl implements MemberRequestLoading {
  const _$MemberRequestLoadingImpl();

  @override
  String toString() {
    return 'MemberRequestState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberRequestModel> list) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberRequestModel> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberRequestModel> list)? loaded,
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
    required TResult Function(MemberRequestStateInitial value) initial,
    required TResult Function(MemberRequestLoading value) loading,
    required TResult Function(MemberRequestLoaded value) loaded,
    required TResult Function(MemberRequestError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemberRequestStateInitial value)? initial,
    TResult? Function(MemberRequestLoading value)? loading,
    TResult? Function(MemberRequestLoaded value)? loaded,
    TResult? Function(MemberRequestError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemberRequestStateInitial value)? initial,
    TResult Function(MemberRequestLoading value)? loading,
    TResult Function(MemberRequestLoaded value)? loaded,
    TResult Function(MemberRequestError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MemberRequestLoading implements MemberRequestState {
  const factory MemberRequestLoading() = _$MemberRequestLoadingImpl;
}

/// @nodoc
abstract class _$$MemberRequestLoadedImplCopyWith<$Res> {
  factory _$$MemberRequestLoadedImplCopyWith(_$MemberRequestLoadedImpl value,
          $Res Function(_$MemberRequestLoadedImpl) then) =
      __$$MemberRequestLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MemberRequestModel> list});
}

/// @nodoc
class __$$MemberRequestLoadedImplCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestLoadedImpl>
    implements _$$MemberRequestLoadedImplCopyWith<$Res> {
  __$$MemberRequestLoadedImplCopyWithImpl(_$MemberRequestLoadedImpl _value,
      $Res Function(_$MemberRequestLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$MemberRequestLoadedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MemberRequestModel>,
    ));
  }
}

/// @nodoc

class _$MemberRequestLoadedImpl implements MemberRequestLoaded {
  const _$MemberRequestLoadedImpl(final List<MemberRequestModel> list)
      : _list = list;

  final List<MemberRequestModel> _list;
  @override
  List<MemberRequestModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'MemberRequestState.loaded(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestLoadedImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRequestLoadedImplCopyWith<_$MemberRequestLoadedImpl> get copyWith =>
      __$$MemberRequestLoadedImplCopyWithImpl<_$MemberRequestLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberRequestModel> list) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberRequestModel> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberRequestModel> list)? loaded,
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
    required TResult Function(MemberRequestStateInitial value) initial,
    required TResult Function(MemberRequestLoading value) loading,
    required TResult Function(MemberRequestLoaded value) loaded,
    required TResult Function(MemberRequestError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemberRequestStateInitial value)? initial,
    TResult? Function(MemberRequestLoading value)? loading,
    TResult? Function(MemberRequestLoaded value)? loaded,
    TResult? Function(MemberRequestError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemberRequestStateInitial value)? initial,
    TResult Function(MemberRequestLoading value)? loading,
    TResult Function(MemberRequestLoaded value)? loaded,
    TResult Function(MemberRequestError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MemberRequestLoaded implements MemberRequestState {
  const factory MemberRequestLoaded(final List<MemberRequestModel> list) =
      _$MemberRequestLoadedImpl;

  List<MemberRequestModel> get list;
  @JsonKey(ignore: true)
  _$$MemberRequestLoadedImplCopyWith<_$MemberRequestLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MemberRequestErrorImplCopyWith<$Res> {
  factory _$$MemberRequestErrorImplCopyWith(_$MemberRequestErrorImpl value,
          $Res Function(_$MemberRequestErrorImpl) then) =
      __$$MemberRequestErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$MemberRequestErrorImplCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestErrorImpl>
    implements _$$MemberRequestErrorImplCopyWith<$Res> {
  __$$MemberRequestErrorImplCopyWithImpl(_$MemberRequestErrorImpl _value,
      $Res Function(_$MemberRequestErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MemberRequestErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MemberRequestErrorImpl implements MemberRequestError {
  const _$MemberRequestErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'MemberRequestState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRequestErrorImplCopyWith<_$MemberRequestErrorImpl> get copyWith =>
      __$$MemberRequestErrorImplCopyWithImpl<_$MemberRequestErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberRequestModel> list) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberRequestModel> list)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberRequestModel> list)? loaded,
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
    required TResult Function(MemberRequestStateInitial value) initial,
    required TResult Function(MemberRequestLoading value) loading,
    required TResult Function(MemberRequestLoaded value) loaded,
    required TResult Function(MemberRequestError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MemberRequestStateInitial value)? initial,
    TResult? Function(MemberRequestLoading value)? loading,
    TResult? Function(MemberRequestLoaded value)? loaded,
    TResult? Function(MemberRequestError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MemberRequestStateInitial value)? initial,
    TResult Function(MemberRequestLoading value)? loading,
    TResult Function(MemberRequestLoaded value)? loaded,
    TResult Function(MemberRequestError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MemberRequestError implements MemberRequestState {
  const factory MemberRequestError(final String error) =
      _$MemberRequestErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$MemberRequestErrorImplCopyWith<_$MemberRequestErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

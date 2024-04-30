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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$MemberRequestStateInitialCopyWith<$Res> {
  factory _$$MemberRequestStateInitialCopyWith(
          _$MemberRequestStateInitial value,
          $Res Function(_$MemberRequestStateInitial) then) =
      __$$MemberRequestStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemberRequestStateInitialCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestStateInitial>
    implements _$$MemberRequestStateInitialCopyWith<$Res> {
  __$$MemberRequestStateInitialCopyWithImpl(_$MemberRequestStateInitial _value,
      $Res Function(_$MemberRequestStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MemberRequestStateInitial implements MemberRequestStateInitial {
  const _$MemberRequestStateInitial();

  @override
  String toString() {
    return 'MemberRequestState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestStateInitial);
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
  const factory MemberRequestStateInitial() = _$MemberRequestStateInitial;
}

/// @nodoc
abstract class _$$MemberRequestLoadingCopyWith<$Res> {
  factory _$$MemberRequestLoadingCopyWith(_$MemberRequestLoading value,
          $Res Function(_$MemberRequestLoading) then) =
      __$$MemberRequestLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemberRequestLoadingCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestLoading>
    implements _$$MemberRequestLoadingCopyWith<$Res> {
  __$$MemberRequestLoadingCopyWithImpl(_$MemberRequestLoading _value,
      $Res Function(_$MemberRequestLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MemberRequestLoading implements MemberRequestLoading {
  const _$MemberRequestLoading();

  @override
  String toString() {
    return 'MemberRequestState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MemberRequestLoading);
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
  const factory MemberRequestLoading() = _$MemberRequestLoading;
}

/// @nodoc
abstract class _$$MemberRequestLoadedCopyWith<$Res> {
  factory _$$MemberRequestLoadedCopyWith(_$MemberRequestLoaded value,
          $Res Function(_$MemberRequestLoaded) then) =
      __$$MemberRequestLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MemberRequestModel> list});
}

/// @nodoc
class __$$MemberRequestLoadedCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestLoaded>
    implements _$$MemberRequestLoadedCopyWith<$Res> {
  __$$MemberRequestLoadedCopyWithImpl(
      _$MemberRequestLoaded _value, $Res Function(_$MemberRequestLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$MemberRequestLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MemberRequestModel>,
    ));
  }
}

/// @nodoc

class _$MemberRequestLoaded implements MemberRequestLoaded {
  const _$MemberRequestLoaded(final List<MemberRequestModel> list)
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRequestLoadedCopyWith<_$MemberRequestLoaded> get copyWith =>
      __$$MemberRequestLoadedCopyWithImpl<_$MemberRequestLoaded>(
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
      _$MemberRequestLoaded;

  List<MemberRequestModel> get list;
  @JsonKey(ignore: true)
  _$$MemberRequestLoadedCopyWith<_$MemberRequestLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MemberRequestErrorCopyWith<$Res> {
  factory _$$MemberRequestErrorCopyWith(_$MemberRequestError value,
          $Res Function(_$MemberRequestError) then) =
      __$$MemberRequestErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$MemberRequestErrorCopyWithImpl<$Res>
    extends _$MemberRequestStateCopyWithImpl<$Res, _$MemberRequestError>
    implements _$$MemberRequestErrorCopyWith<$Res> {
  __$$MemberRequestErrorCopyWithImpl(
      _$MemberRequestError _value, $Res Function(_$MemberRequestError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MemberRequestError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MemberRequestError implements MemberRequestError {
  const _$MemberRequestError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'MemberRequestState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRequestError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRequestErrorCopyWith<_$MemberRequestError> get copyWith =>
      __$$MemberRequestErrorCopyWithImpl<_$MemberRequestError>(
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
  const factory MemberRequestError(final String error) = _$MemberRequestError;

  String get error;
  @JsonKey(ignore: true)
  _$$MemberRequestErrorCopyWith<_$MemberRequestError> get copyWith =>
      throw _privateConstructorUsedError;
}

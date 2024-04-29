// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_bookings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyBookingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingModel> bookings, bool isRefreshLoader)
        loaded,
    required TResult Function(String msg) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingModel> bookings, bool isRefreshLoader)?
        loaded,
    TResult? Function(String msg)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingModel> bookings, bool isRefreshLoader)? loaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyBookingsStateInitial value) initial,
    required TResult Function(MyBookingsStateLoading value) loading,
    required TResult Function(MyBookingsStateLoaded value) loaded,
    required TResult Function(MyBookingsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyBookingsStateInitial value)? initial,
    TResult? Function(MyBookingsStateLoading value)? loading,
    TResult? Function(MyBookingsStateLoaded value)? loaded,
    TResult? Function(MyBookingsStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyBookingsStateInitial value)? initial,
    TResult Function(MyBookingsStateLoading value)? loading,
    TResult Function(MyBookingsStateLoaded value)? loaded,
    TResult Function(MyBookingsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsStateCopyWith(
          MyBookingsState value, $Res Function(MyBookingsState) then) =
      _$MyBookingsStateCopyWithImpl<$Res, MyBookingsState>;
}

/// @nodoc
class _$MyBookingsStateCopyWithImpl<$Res, $Val extends MyBookingsState>
    implements $MyBookingsStateCopyWith<$Res> {
  _$MyBookingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MyBookingsStateInitialCopyWith<$Res> {
  factory _$$MyBookingsStateInitialCopyWith(_$MyBookingsStateInitial value,
          $Res Function(_$MyBookingsStateInitial) then) =
      __$$MyBookingsStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyBookingsStateInitialCopyWithImpl<$Res>
    extends _$MyBookingsStateCopyWithImpl<$Res, _$MyBookingsStateInitial>
    implements _$$MyBookingsStateInitialCopyWith<$Res> {
  __$$MyBookingsStateInitialCopyWithImpl(_$MyBookingsStateInitial _value,
      $Res Function(_$MyBookingsStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MyBookingsStateInitial implements MyBookingsStateInitial {
  const _$MyBookingsStateInitial();

  @override
  String toString() {
    return 'MyBookingsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MyBookingsStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingModel> bookings, bool isRefreshLoader)
        loaded,
    required TResult Function(String msg) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingModel> bookings, bool isRefreshLoader)?
        loaded,
    TResult? Function(String msg)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingModel> bookings, bool isRefreshLoader)? loaded,
    TResult Function(String msg)? error,
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
    required TResult Function(MyBookingsStateInitial value) initial,
    required TResult Function(MyBookingsStateLoading value) loading,
    required TResult Function(MyBookingsStateLoaded value) loaded,
    required TResult Function(MyBookingsStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyBookingsStateInitial value)? initial,
    TResult? Function(MyBookingsStateLoading value)? loading,
    TResult? Function(MyBookingsStateLoaded value)? loaded,
    TResult? Function(MyBookingsStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyBookingsStateInitial value)? initial,
    TResult Function(MyBookingsStateLoading value)? loading,
    TResult Function(MyBookingsStateLoaded value)? loaded,
    TResult Function(MyBookingsStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MyBookingsStateInitial implements MyBookingsState {
  const factory MyBookingsStateInitial() = _$MyBookingsStateInitial;
}

/// @nodoc
abstract class _$$MyBookingsStateLoadingCopyWith<$Res> {
  factory _$$MyBookingsStateLoadingCopyWith(_$MyBookingsStateLoading value,
          $Res Function(_$MyBookingsStateLoading) then) =
      __$$MyBookingsStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyBookingsStateLoadingCopyWithImpl<$Res>
    extends _$MyBookingsStateCopyWithImpl<$Res, _$MyBookingsStateLoading>
    implements _$$MyBookingsStateLoadingCopyWith<$Res> {
  __$$MyBookingsStateLoadingCopyWithImpl(_$MyBookingsStateLoading _value,
      $Res Function(_$MyBookingsStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MyBookingsStateLoading implements MyBookingsStateLoading {
  const _$MyBookingsStateLoading();

  @override
  String toString() {
    return 'MyBookingsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MyBookingsStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingModel> bookings, bool isRefreshLoader)
        loaded,
    required TResult Function(String msg) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingModel> bookings, bool isRefreshLoader)?
        loaded,
    TResult? Function(String msg)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingModel> bookings, bool isRefreshLoader)? loaded,
    TResult Function(String msg)? error,
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
    required TResult Function(MyBookingsStateInitial value) initial,
    required TResult Function(MyBookingsStateLoading value) loading,
    required TResult Function(MyBookingsStateLoaded value) loaded,
    required TResult Function(MyBookingsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyBookingsStateInitial value)? initial,
    TResult? Function(MyBookingsStateLoading value)? loading,
    TResult? Function(MyBookingsStateLoaded value)? loaded,
    TResult? Function(MyBookingsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyBookingsStateInitial value)? initial,
    TResult Function(MyBookingsStateLoading value)? loading,
    TResult Function(MyBookingsStateLoaded value)? loaded,
    TResult Function(MyBookingsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MyBookingsStateLoading implements MyBookingsState {
  const factory MyBookingsStateLoading() = _$MyBookingsStateLoading;
}

/// @nodoc
abstract class _$$MyBookingsStateLoadedCopyWith<$Res> {
  factory _$$MyBookingsStateLoadedCopyWith(_$MyBookingsStateLoaded value,
          $Res Function(_$MyBookingsStateLoaded) then) =
      __$$MyBookingsStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BookingModel> bookings, bool isRefreshLoader});
}

/// @nodoc
class __$$MyBookingsStateLoadedCopyWithImpl<$Res>
    extends _$MyBookingsStateCopyWithImpl<$Res, _$MyBookingsStateLoaded>
    implements _$$MyBookingsStateLoadedCopyWith<$Res> {
  __$$MyBookingsStateLoadedCopyWithImpl(_$MyBookingsStateLoaded _value,
      $Res Function(_$MyBookingsStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? isRefreshLoader = null,
  }) {
    return _then(_$MyBookingsStateLoaded(
      null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<BookingModel>,
      null == isRefreshLoader
          ? _value.isRefreshLoader
          : isRefreshLoader // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MyBookingsStateLoaded implements MyBookingsStateLoaded {
  const _$MyBookingsStateLoaded(
      final List<BookingModel> bookings, this.isRefreshLoader)
      : _bookings = bookings;

  final List<BookingModel> _bookings;
  @override
  List<BookingModel> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  final bool isRefreshLoader;

  @override
  String toString() {
    return 'MyBookingsState.loaded(bookings: $bookings, isRefreshLoader: $isRefreshLoader)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyBookingsStateLoaded &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            (identical(other.isRefreshLoader, isRefreshLoader) ||
                other.isRefreshLoader == isRefreshLoader));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_bookings), isRefreshLoader);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyBookingsStateLoadedCopyWith<_$MyBookingsStateLoaded> get copyWith =>
      __$$MyBookingsStateLoadedCopyWithImpl<_$MyBookingsStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingModel> bookings, bool isRefreshLoader)
        loaded,
    required TResult Function(String msg) error,
  }) {
    return loaded(bookings, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingModel> bookings, bool isRefreshLoader)?
        loaded,
    TResult? Function(String msg)? error,
  }) {
    return loaded?.call(bookings, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingModel> bookings, bool isRefreshLoader)? loaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bookings, isRefreshLoader);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyBookingsStateInitial value) initial,
    required TResult Function(MyBookingsStateLoading value) loading,
    required TResult Function(MyBookingsStateLoaded value) loaded,
    required TResult Function(MyBookingsStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyBookingsStateInitial value)? initial,
    TResult? Function(MyBookingsStateLoading value)? loading,
    TResult? Function(MyBookingsStateLoaded value)? loaded,
    TResult? Function(MyBookingsStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyBookingsStateInitial value)? initial,
    TResult Function(MyBookingsStateLoading value)? loading,
    TResult Function(MyBookingsStateLoaded value)? loaded,
    TResult Function(MyBookingsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MyBookingsStateLoaded implements MyBookingsState {
  const factory MyBookingsStateLoaded(
          final List<BookingModel> bookings, final bool isRefreshLoader) =
      _$MyBookingsStateLoaded;

  List<BookingModel> get bookings;
  bool get isRefreshLoader;
  @JsonKey(ignore: true)
  _$$MyBookingsStateLoadedCopyWith<_$MyBookingsStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MyBookingsStateErrorCopyWith<$Res> {
  factory _$$MyBookingsStateErrorCopyWith(_$MyBookingsStateError value,
          $Res Function(_$MyBookingsStateError) then) =
      __$$MyBookingsStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$MyBookingsStateErrorCopyWithImpl<$Res>
    extends _$MyBookingsStateCopyWithImpl<$Res, _$MyBookingsStateError>
    implements _$$MyBookingsStateErrorCopyWith<$Res> {
  __$$MyBookingsStateErrorCopyWithImpl(_$MyBookingsStateError _value,
      $Res Function(_$MyBookingsStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$MyBookingsStateError(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyBookingsStateError implements MyBookingsStateError {
  const _$MyBookingsStateError(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'MyBookingsState.error(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyBookingsStateError &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyBookingsStateErrorCopyWith<_$MyBookingsStateError> get copyWith =>
      __$$MyBookingsStateErrorCopyWithImpl<_$MyBookingsStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingModel> bookings, bool isRefreshLoader)
        loaded,
    required TResult Function(String msg) error,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingModel> bookings, bool isRefreshLoader)?
        loaded,
    TResult? Function(String msg)? error,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingModel> bookings, bool isRefreshLoader)? loaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyBookingsStateInitial value) initial,
    required TResult Function(MyBookingsStateLoading value) loading,
    required TResult Function(MyBookingsStateLoaded value) loaded,
    required TResult Function(MyBookingsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyBookingsStateInitial value)? initial,
    TResult? Function(MyBookingsStateLoading value)? loading,
    TResult? Function(MyBookingsStateLoaded value)? loaded,
    TResult? Function(MyBookingsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyBookingsStateInitial value)? initial,
    TResult Function(MyBookingsStateLoading value)? loading,
    TResult Function(MyBookingsStateLoaded value)? loaded,
    TResult Function(MyBookingsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MyBookingsStateError implements MyBookingsState {
  const factory MyBookingsStateError(final String msg) = _$MyBookingsStateError;

  String get msg;
  @JsonKey(ignore: true)
  _$$MyBookingsStateErrorCopyWith<_$MyBookingsStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

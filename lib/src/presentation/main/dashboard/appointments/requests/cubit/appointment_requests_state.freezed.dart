// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppointmentRequestsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppointmentRequestsStateLoading value) loading,
    required TResult Function(AppointmentRequestsStateLoaded value) loaded,
    required TResult Function(AppointmentRequestsStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppointmentRequestsStateLoading value)? loading,
    TResult? Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult? Function(AppointmentRequestsStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppointmentRequestsStateLoading value)? loading,
    TResult Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult Function(AppointmentRequestsStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentRequestsStateCopyWith<$Res> {
  factory $AppointmentRequestsStateCopyWith(AppointmentRequestsState value,
          $Res Function(AppointmentRequestsState) then) =
      _$AppointmentRequestsStateCopyWithImpl<$Res, AppointmentRequestsState>;
}

/// @nodoc
class _$AppointmentRequestsStateCopyWithImpl<$Res,
        $Val extends AppointmentRequestsState>
    implements $AppointmentRequestsStateCopyWith<$Res> {
  _$AppointmentRequestsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppointmentRequestsStateLoadingCopyWith<$Res> {
  factory _$$AppointmentRequestsStateLoadingCopyWith(
          _$AppointmentRequestsStateLoading value,
          $Res Function(_$AppointmentRequestsStateLoading) then) =
      __$$AppointmentRequestsStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppointmentRequestsStateLoadingCopyWithImpl<$Res>
    extends _$AppointmentRequestsStateCopyWithImpl<$Res,
        _$AppointmentRequestsStateLoading>
    implements _$$AppointmentRequestsStateLoadingCopyWith<$Res> {
  __$$AppointmentRequestsStateLoadingCopyWithImpl(
      _$AppointmentRequestsStateLoading _value,
      $Res Function(_$AppointmentRequestsStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppointmentRequestsStateLoading
    implements AppointmentRequestsStateLoading {
  const _$AppointmentRequestsStateLoading();

  @override
  String toString() {
    return 'AppointmentRequestsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestsStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
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
    required TResult Function(AppointmentRequestsStateLoading value) loading,
    required TResult Function(AppointmentRequestsStateLoaded value) loaded,
    required TResult Function(AppointmentRequestsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppointmentRequestsStateLoading value)? loading,
    TResult? Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult? Function(AppointmentRequestsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppointmentRequestsStateLoading value)? loading,
    TResult Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult Function(AppointmentRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AppointmentRequestsStateLoading
    implements AppointmentRequestsState {
  const factory AppointmentRequestsStateLoading() =
      _$AppointmentRequestsStateLoading;
}

/// @nodoc
abstract class _$$AppointmentRequestsStateLoadedCopyWith<$Res> {
  factory _$$AppointmentRequestsStateLoadedCopyWith(
          _$AppointmentRequestsStateLoaded value,
          $Res Function(_$AppointmentRequestsStateLoaded) then) =
      __$$AppointmentRequestsStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> appointments, bool isRefreshLoader});
}

/// @nodoc
class __$$AppointmentRequestsStateLoadedCopyWithImpl<$Res>
    extends _$AppointmentRequestsStateCopyWithImpl<$Res,
        _$AppointmentRequestsStateLoaded>
    implements _$$AppointmentRequestsStateLoadedCopyWith<$Res> {
  __$$AppointmentRequestsStateLoadedCopyWithImpl(
      _$AppointmentRequestsStateLoaded _value,
      $Res Function(_$AppointmentRequestsStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? isRefreshLoader = null,
  }) {
    return _then(_$AppointmentRequestsStateLoaded(
      null == appointments
          ? _value._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == isRefreshLoader
          ? _value.isRefreshLoader
          : isRefreshLoader // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppointmentRequestsStateLoaded
    implements AppointmentRequestsStateLoaded {
  const _$AppointmentRequestsStateLoaded(
      final List<String> appointments, this.isRefreshLoader)
      : _appointments = appointments;

  final List<String> _appointments;
  @override
  List<String> get appointments {
    if (_appointments is EqualUnmodifiableListView) return _appointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appointments);
  }

  @override
  final bool isRefreshLoader;

  @override
  String toString() {
    return 'AppointmentRequestsState.loaded(appointments: $appointments, isRefreshLoader: $isRefreshLoader)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestsStateLoaded &&
            const DeepCollectionEquality()
                .equals(other._appointments, _appointments) &&
            (identical(other.isRefreshLoader, isRefreshLoader) ||
                other.isRefreshLoader == isRefreshLoader));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_appointments), isRefreshLoader);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestsStateLoadedCopyWith<_$AppointmentRequestsStateLoaded>
      get copyWith => __$$AppointmentRequestsStateLoadedCopyWithImpl<
          _$AppointmentRequestsStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(appointments, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(appointments, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(appointments, isRefreshLoader);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppointmentRequestsStateLoading value) loading,
    required TResult Function(AppointmentRequestsStateLoaded value) loaded,
    required TResult Function(AppointmentRequestsStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppointmentRequestsStateLoading value)? loading,
    TResult? Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult? Function(AppointmentRequestsStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppointmentRequestsStateLoading value)? loading,
    TResult Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult Function(AppointmentRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AppointmentRequestsStateLoaded
    implements AppointmentRequestsState {
  const factory AppointmentRequestsStateLoaded(
          final List<String> appointments, final bool isRefreshLoader) =
      _$AppointmentRequestsStateLoaded;

  List<String> get appointments;
  bool get isRefreshLoader;
  @JsonKey(ignore: true)
  _$$AppointmentRequestsStateLoadedCopyWith<_$AppointmentRequestsStateLoaded>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppointmentRequestsStateErrorCopyWith<$Res> {
  factory _$$AppointmentRequestsStateErrorCopyWith(
          _$AppointmentRequestsStateError value,
          $Res Function(_$AppointmentRequestsStateError) then) =
      __$$AppointmentRequestsStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$AppointmentRequestsStateErrorCopyWithImpl<$Res>
    extends _$AppointmentRequestsStateCopyWithImpl<$Res,
        _$AppointmentRequestsStateError>
    implements _$$AppointmentRequestsStateErrorCopyWith<$Res> {
  __$$AppointmentRequestsStateErrorCopyWithImpl(
      _$AppointmentRequestsStateError _value,
      $Res Function(_$AppointmentRequestsStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$AppointmentRequestsStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppointmentRequestsStateError implements AppointmentRequestsStateError {
  const _$AppointmentRequestsStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'AppointmentRequestsState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestsStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestsStateErrorCopyWith<_$AppointmentRequestsStateError>
      get copyWith => __$$AppointmentRequestsStateErrorCopyWithImpl<
          _$AppointmentRequestsStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
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
    required TResult Function(AppointmentRequestsStateLoading value) loading,
    required TResult Function(AppointmentRequestsStateLoaded value) loaded,
    required TResult Function(AppointmentRequestsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppointmentRequestsStateLoading value)? loading,
    TResult? Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult? Function(AppointmentRequestsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppointmentRequestsStateLoading value)? loading,
    TResult Function(AppointmentRequestsStateLoaded value)? loaded,
    TResult Function(AppointmentRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AppointmentRequestsStateError
    implements AppointmentRequestsState {
  const factory AppointmentRequestsStateError(final String error) =
      _$AppointmentRequestsStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$AppointmentRequestsStateErrorCopyWith<_$AppointmentRequestsStateError>
      get copyWith => throw _privateConstructorUsedError;
}

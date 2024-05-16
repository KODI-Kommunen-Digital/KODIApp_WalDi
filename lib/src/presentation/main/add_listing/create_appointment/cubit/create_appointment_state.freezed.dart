// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_appointment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateAppointmentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAppointmentLoading value) loading,
    required TResult Function(CreateAppointmentLoaded value) loaded,
    required TResult Function(CreateAppointmentError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAppointmentLoading value)? loading,
    TResult? Function(CreateAppointmentLoaded value)? loaded,
    TResult? Function(CreateAppointmentError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAppointmentLoading value)? loading,
    TResult Function(CreateAppointmentLoaded value)? loaded,
    TResult Function(CreateAppointmentError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAppointmentStateCopyWith<$Res> {
  factory $CreateAppointmentStateCopyWith(CreateAppointmentState value,
          $Res Function(CreateAppointmentState) then) =
      _$CreateAppointmentStateCopyWithImpl<$Res, CreateAppointmentState>;
}

/// @nodoc
class _$CreateAppointmentStateCopyWithImpl<$Res,
        $Val extends CreateAppointmentState>
    implements $CreateAppointmentStateCopyWith<$Res> {
  _$CreateAppointmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateAppointmentLoadingImplCopyWith<$Res> {
  factory _$$CreateAppointmentLoadingImplCopyWith(
          _$CreateAppointmentLoadingImpl value,
          $Res Function(_$CreateAppointmentLoadingImpl) then) =
      __$$CreateAppointmentLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateAppointmentLoadingImplCopyWithImpl<$Res>
    extends _$CreateAppointmentStateCopyWithImpl<$Res,
        _$CreateAppointmentLoadingImpl>
    implements _$$CreateAppointmentLoadingImplCopyWith<$Res> {
  __$$CreateAppointmentLoadingImplCopyWithImpl(
      _$CreateAppointmentLoadingImpl _value,
      $Res Function(_$CreateAppointmentLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateAppointmentLoadingImpl implements CreateAppointmentLoading {
  const _$CreateAppointmentLoadingImpl();

  @override
  String toString() {
    return 'CreateAppointmentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAppointmentLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
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
    required TResult Function(CreateAppointmentLoading value) loading,
    required TResult Function(CreateAppointmentLoaded value) loaded,
    required TResult Function(CreateAppointmentError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAppointmentLoading value)? loading,
    TResult? Function(CreateAppointmentLoaded value)? loaded,
    TResult? Function(CreateAppointmentError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAppointmentLoading value)? loading,
    TResult Function(CreateAppointmentLoaded value)? loaded,
    TResult Function(CreateAppointmentError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CreateAppointmentLoading implements CreateAppointmentState {
  const factory CreateAppointmentLoading() = _$CreateAppointmentLoadingImpl;
}

/// @nodoc
abstract class _$$CreateAppointmentLoadedImplCopyWith<$Res> {
  factory _$$CreateAppointmentLoadedImplCopyWith(
          _$CreateAppointmentLoadedImpl value,
          $Res Function(_$CreateAppointmentLoadedImpl) then) =
      __$$CreateAppointmentLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<AppointmentServiceModel>? loadedEntries,
      AppointmentModel appointment});
}

/// @nodoc
class __$$CreateAppointmentLoadedImplCopyWithImpl<$Res>
    extends _$CreateAppointmentStateCopyWithImpl<$Res,
        _$CreateAppointmentLoadedImpl>
    implements _$$CreateAppointmentLoadedImplCopyWith<$Res> {
  __$$CreateAppointmentLoadedImplCopyWithImpl(
      _$CreateAppointmentLoadedImpl _value,
      $Res Function(_$CreateAppointmentLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadedEntries = freezed,
    Object? appointment = null,
  }) {
    return _then(_$CreateAppointmentLoadedImpl(
      freezed == loadedEntries
          ? _value._loadedEntries
          : loadedEntries // ignore: cast_nullable_to_non_nullable
              as List<AppointmentServiceModel>?,
      null == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as AppointmentModel,
    ));
  }
}

/// @nodoc

class _$CreateAppointmentLoadedImpl implements CreateAppointmentLoaded {
  const _$CreateAppointmentLoadedImpl(
      final List<AppointmentServiceModel>? loadedEntries, this.appointment)
      : _loadedEntries = loadedEntries;

  final List<AppointmentServiceModel>? _loadedEntries;
  @override
  List<AppointmentServiceModel>? get loadedEntries {
    final value = _loadedEntries;
    if (value == null) return null;
    if (_loadedEntries is EqualUnmodifiableListView) return _loadedEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AppointmentModel appointment;

  @override
  String toString() {
    return 'CreateAppointmentState.loaded(loadedEntries: $loadedEntries, appointment: $appointment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAppointmentLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._loadedEntries, _loadedEntries) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_loadedEntries), appointment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAppointmentLoadedImplCopyWith<_$CreateAppointmentLoadedImpl>
      get copyWith => __$$CreateAppointmentLoadedImplCopyWithImpl<
          _$CreateAppointmentLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(loadedEntries, appointment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(loadedEntries, appointment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(loadedEntries, appointment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAppointmentLoading value) loading,
    required TResult Function(CreateAppointmentLoaded value) loaded,
    required TResult Function(CreateAppointmentError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAppointmentLoading value)? loading,
    TResult? Function(CreateAppointmentLoaded value)? loaded,
    TResult? Function(CreateAppointmentError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAppointmentLoading value)? loading,
    TResult Function(CreateAppointmentLoaded value)? loaded,
    TResult Function(CreateAppointmentError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CreateAppointmentLoaded implements CreateAppointmentState {
  const factory CreateAppointmentLoaded(
      final List<AppointmentServiceModel>? loadedEntries,
      final AppointmentModel appointment) = _$CreateAppointmentLoadedImpl;

  List<AppointmentServiceModel>? get loadedEntries;
  AppointmentModel get appointment;
  @JsonKey(ignore: true)
  _$$CreateAppointmentLoadedImplCopyWith<_$CreateAppointmentLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateAppointmentErrorImplCopyWith<$Res> {
  factory _$$CreateAppointmentErrorImplCopyWith(
          _$CreateAppointmentErrorImpl value,
          $Res Function(_$CreateAppointmentErrorImpl) then) =
      __$$CreateAppointmentErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CreateAppointmentErrorImplCopyWithImpl<$Res>
    extends _$CreateAppointmentStateCopyWithImpl<$Res,
        _$CreateAppointmentErrorImpl>
    implements _$$CreateAppointmentErrorImplCopyWith<$Res> {
  __$$CreateAppointmentErrorImplCopyWithImpl(
      _$CreateAppointmentErrorImpl _value,
      $Res Function(_$CreateAppointmentErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CreateAppointmentErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateAppointmentErrorImpl implements CreateAppointmentError {
  const _$CreateAppointmentErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CreateAppointmentState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAppointmentErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAppointmentErrorImplCopyWith<_$CreateAppointmentErrorImpl>
      get copyWith => __$$CreateAppointmentErrorImplCopyWithImpl<
          _$CreateAppointmentErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<AppointmentServiceModel>? loadedEntries,
            AppointmentModel appointment)?
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
    required TResult Function(CreateAppointmentLoading value) loading,
    required TResult Function(CreateAppointmentLoaded value) loaded,
    required TResult Function(CreateAppointmentError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAppointmentLoading value)? loading,
    TResult? Function(CreateAppointmentLoaded value)? loaded,
    TResult? Function(CreateAppointmentError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAppointmentLoading value)? loading,
    TResult Function(CreateAppointmentLoaded value)? loaded,
    TResult Function(CreateAppointmentError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreateAppointmentError implements CreateAppointmentState {
  const factory CreateAppointmentError(final String error) =
      _$CreateAppointmentErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$CreateAppointmentErrorImplCopyWith<_$CreateAppointmentErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

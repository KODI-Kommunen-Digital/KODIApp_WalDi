// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateLoaded value) loaded,
    required TResult Function(BookingStateError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingStateLoading value)? loading,
    TResult? Function(BookingStateLoaded value)? loaded,
    TResult? Function(BookingStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateLoaded value)? loaded,
    TResult Function(BookingStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
          BookingState value, $Res Function(BookingState) then) =
      _$BookingStateCopyWithImpl<$Res, BookingState>;
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res, $Val extends BookingState>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

// ignore: unused_field
  final $Val _value;
// ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookingStateLoadingImplCopyWith<$Res> {
  factory _$$BookingStateLoadingImplCopyWith(_$BookingStateLoadingImpl value,
          $Res Function(_$BookingStateLoadingImpl) then) =
      __$$BookingStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingStateLoadingImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateLoadingImpl>
    implements _$$BookingStateLoadingImplCopyWith<$Res> {
  __$$BookingStateLoadingImplCopyWithImpl(_$BookingStateLoadingImpl _value,
      $Res Function(_$BookingStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookingStateLoadingImpl implements BookingStateLoading {
  const _$BookingStateLoadingImpl();

  @override
  String toString() {
    return 'BookingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateLoaded value) loaded,
    required TResult Function(BookingStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingStateLoading value)? loading,
    TResult? Function(BookingStateLoaded value)? loaded,
    TResult? Function(BookingStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateLoaded value)? loaded,
    TResult Function(BookingStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookingStateLoading implements BookingState {
  const factory BookingStateLoading() = _$BookingStateLoadingImpl;
}

/// @nodoc
abstract class _$$BookingStateLoadedImplCopyWith<$Res> {
  factory _$$BookingStateLoadedImplCopyWith(_$BookingStateLoadedImpl value,
          $Res Function(_$BookingStateLoadedImpl) then) =
      __$$BookingStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AppointmentSlotModel? slot,
      List<AppointmentServiceModel> services,
      AppointmentModel appointment,
      bool isEmpty,
      UserModel userModel});
}

/// @nodoc
class __$$BookingStateLoadedImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateLoadedImpl>
    implements _$$BookingStateLoadedImplCopyWith<$Res> {
  __$$BookingStateLoadedImplCopyWithImpl(_$BookingStateLoadedImpl _value,
      $Res Function(_$BookingStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slot = freezed,
    Object? services = null,
    Object? appointment = null,
    Object? isEmpty = null,
    Object? userModel = null,
  }) {
    return _then(_$BookingStateLoadedImpl(
      freezed == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as AppointmentSlotModel?,
      null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<AppointmentServiceModel>,
      null == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as AppointmentModel,
      null == isEmpty
          ? _value.isEmpty
          : isEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      null == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$BookingStateLoadedImpl implements BookingStateLoaded {
  const _$BookingStateLoadedImpl(
      this.slot,
      final List<AppointmentServiceModel> services,
      this.appointment,
      this.isEmpty,
      this.userModel)
      : _services = services;

  @override
  final AppointmentSlotModel? slot;
  final List<AppointmentServiceModel> _services;
  @override
  List<AppointmentServiceModel> get services {
    if (_services is EqualUnmodifiableListView) return _services;
// ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  final AppointmentModel appointment;
  @override
  final bool isEmpty;
  @override
  final UserModel userModel;

  @override
  String toString() {
    return 'BookingState.loaded(slot: $slot, services: $services, appointment: $appointment, isEmpty: $isEmpty, userModel: $userModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateLoadedImpl &&
            (identical(other.slot, slot) || other.slot == slot) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment) &&
            (identical(other.isEmpty, isEmpty) || other.isEmpty == isEmpty) &&
            (identical(other.userModel, userModel) ||
                other.userModel == userModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      slot,
      const DeepCollectionEquality().hash(_services),
      appointment,
      isEmpty,
      userModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateLoadedImplCopyWith<_$BookingStateLoadedImpl> get copyWith =>
      __$$BookingStateLoadedImplCopyWithImpl<_$BookingStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(slot, services, appointment, isEmpty, userModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(slot, services, appointment, isEmpty, userModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(slot, services, appointment, isEmpty, userModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateLoaded value) loaded,
    required TResult Function(BookingStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingStateLoading value)? loading,
    TResult? Function(BookingStateLoaded value)? loaded,
    TResult? Function(BookingStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateLoaded value)? loaded,
    TResult Function(BookingStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BookingStateLoaded implements BookingState {
  const factory BookingStateLoaded(
      final AppointmentSlotModel? slot,
      final List<AppointmentServiceModel> services,
      final AppointmentModel appointment,
      final bool isEmpty,
      final UserModel userModel) = _$BookingStateLoadedImpl;

  AppointmentSlotModel? get slot;
  List<AppointmentServiceModel> get services;
  AppointmentModel get appointment;
  bool get isEmpty;
  UserModel get userModel;
  @JsonKey(ignore: true)
  _$$BookingStateLoadedImplCopyWith<_$BookingStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingStateErrorImplCopyWith<$Res> {
  factory _$$BookingStateErrorImplCopyWith(_$BookingStateErrorImpl value,
          $Res Function(_$BookingStateErrorImpl) then) =
      __$$BookingStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$BookingStateErrorImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateErrorImpl>
    implements _$$BookingStateErrorImplCopyWith<$Res> {
  __$$BookingStateErrorImplCopyWithImpl(_$BookingStateErrorImpl _value,
      $Res Function(_$BookingStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$BookingStateErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookingStateErrorImpl implements BookingStateError {
  const _$BookingStateErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'BookingState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateErrorImplCopyWith<_$BookingStateErrorImpl> get copyWith =>
      __$$BookingStateErrorImplCopyWithImpl<_$BookingStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            AppointmentSlotModel? slot,
            List<AppointmentServiceModel> services,
            AppointmentModel appointment,
            bool isEmpty,
            UserModel userModel)?
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
    required TResult Function(BookingStateLoading value) loading,
    required TResult Function(BookingStateLoaded value) loaded,
    required TResult Function(BookingStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingStateLoading value)? loading,
    TResult? Function(BookingStateLoaded value)? loaded,
    TResult? Function(BookingStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingStateLoading value)? loading,
    TResult Function(BookingStateLoaded value)? loaded,
    TResult Function(BookingStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookingStateError implements BookingState {
  const factory BookingStateError(final String error) = _$BookingStateErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$BookingStateErrorImplCopyWith<_$BookingStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

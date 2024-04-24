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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            Map<String, int> availableSlots, List<String> services)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Map<String, int> availableSlots, List<String> services)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Map<String, int> availableSlots, List<String> services)?
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
abstract class _$$BookingStateLoadingCopyWith<$Res> {
  factory _$$BookingStateLoadingCopyWith(_$BookingStateLoading value,
          $Res Function(_$BookingStateLoading) then) =
      __$$BookingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingStateLoadingCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateLoading>
    implements _$$BookingStateLoadingCopyWith<$Res> {
  __$$BookingStateLoadingCopyWithImpl(
      _$BookingStateLoading _value, $Res Function(_$BookingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookingStateLoading implements BookingStateLoading {
  const _$BookingStateLoading();

  @override
  String toString() {
    return 'BookingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            Map<String, int> availableSlots, List<String> services)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Map<String, int> availableSlots, List<String> services)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Map<String, int> availableSlots, List<String> services)?
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
  const factory BookingStateLoading() = _$BookingStateLoading;
}

/// @nodoc
abstract class _$$BookingStateLoadedCopyWith<$Res> {
  factory _$$BookingStateLoadedCopyWith(_$BookingStateLoaded value,
          $Res Function(_$BookingStateLoaded) then) =
      __$$BookingStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, int> availableSlots, List<String> services});
}

/// @nodoc
class __$$BookingStateLoadedCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateLoaded>
    implements _$$BookingStateLoadedCopyWith<$Res> {
  __$$BookingStateLoadedCopyWithImpl(
      _$BookingStateLoaded _value, $Res Function(_$BookingStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableSlots = null,
    Object? services = null,
  }) {
    return _then(_$BookingStateLoaded(
      null == availableSlots
          ? _value._availableSlots
          : availableSlots // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BookingStateLoaded implements BookingStateLoaded {
  const _$BookingStateLoaded(
      final Map<String, int> availableSlots, final List<String> services)
      : _availableSlots = availableSlots,
        _services = services;

  final Map<String, int> _availableSlots;
  @override
  Map<String, int> get availableSlots {
    if (_availableSlots is EqualUnmodifiableMapView) return _availableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableSlots);
  }

  final List<String> _services;
  @override
  List<String> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'BookingState.loaded(availableSlots: $availableSlots, services: $services)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateLoaded &&
            const DeepCollectionEquality()
                .equals(other._availableSlots, _availableSlots) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableSlots),
      const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateLoadedCopyWith<_$BookingStateLoaded> get copyWith =>
      __$$BookingStateLoadedCopyWithImpl<_$BookingStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            Map<String, int> availableSlots, List<String> services)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(availableSlots, services);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Map<String, int> availableSlots, List<String> services)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(availableSlots, services);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Map<String, int> availableSlots, List<String> services)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(availableSlots, services);
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
          final Map<String, int> availableSlots, final List<String> services) =
      _$BookingStateLoaded;

  Map<String, int> get availableSlots;
  List<String> get services;
  @JsonKey(ignore: true)
  _$$BookingStateLoadedCopyWith<_$BookingStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingStateErrorCopyWith<$Res> {
  factory _$$BookingStateErrorCopyWith(
          _$BookingStateError value, $Res Function(_$BookingStateError) then) =
      __$$BookingStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$BookingStateErrorCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingStateError>
    implements _$$BookingStateErrorCopyWith<$Res> {
  __$$BookingStateErrorCopyWithImpl(
      _$BookingStateError _value, $Res Function(_$BookingStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$BookingStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookingStateError implements BookingStateError {
  const _$BookingStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'BookingState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingStateErrorCopyWith<_$BookingStateError> get copyWith =>
      __$$BookingStateErrorCopyWithImpl<_$BookingStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            Map<String, int> availableSlots, List<String> services)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Map<String, int> availableSlots, List<String> services)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Map<String, int> availableSlots, List<String> services)?
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
  const factory BookingStateError(final String error) = _$BookingStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$BookingStateErrorCopyWith<_$BookingStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_appointments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyAppointmentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyAppointmentsStateInitial value) initial,
    required TResult Function(MyAppointmentsStateLoading value) loading,
    required TResult Function(MyAppointmentsStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyAppointmentsStateInitial value)? initial,
    TResult? Function(MyAppointmentsStateLoading value)? loading,
    TResult? Function(MyAppointmentsStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyAppointmentsStateInitial value)? initial,
    TResult Function(MyAppointmentsStateLoading value)? loading,
    TResult Function(MyAppointmentsStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAppointmentsStateCopyWith<$Res> {
  factory $MyAppointmentsStateCopyWith(
          MyAppointmentsState value, $Res Function(MyAppointmentsState) then) =
      _$MyAppointmentsStateCopyWithImpl<$Res, MyAppointmentsState>;
}

/// @nodoc
class _$MyAppointmentsStateCopyWithImpl<$Res, $Val extends MyAppointmentsState>
    implements $MyAppointmentsStateCopyWith<$Res> {
  _$MyAppointmentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MyAppointmentsStateInitialImplCopyWith<$Res> {
  factory _$$MyAppointmentsStateInitialImplCopyWith(
          _$MyAppointmentsStateInitialImpl value,
          $Res Function(_$MyAppointmentsStateInitialImpl) then) =
      __$$MyAppointmentsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyAppointmentsStateInitialImplCopyWithImpl<$Res>
    extends _$MyAppointmentsStateCopyWithImpl<$Res,
        _$MyAppointmentsStateInitialImpl>
    implements _$$MyAppointmentsStateInitialImplCopyWith<$Res> {
  __$$MyAppointmentsStateInitialImplCopyWithImpl(
      _$MyAppointmentsStateInitialImpl _value,
      $Res Function(_$MyAppointmentsStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MyAppointmentsStateInitialImpl implements MyAppointmentsStateInitial {
  const _$MyAppointmentsStateInitialImpl();

  @override
  String toString() {
    return 'MyAppointmentsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyAppointmentsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
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
    required TResult Function(MyAppointmentsStateInitial value) initial,
    required TResult Function(MyAppointmentsStateLoading value) loading,
    required TResult Function(MyAppointmentsStateLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyAppointmentsStateInitial value)? initial,
    TResult? Function(MyAppointmentsStateLoading value)? loading,
    TResult? Function(MyAppointmentsStateLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyAppointmentsStateInitial value)? initial,
    TResult Function(MyAppointmentsStateLoading value)? loading,
    TResult Function(MyAppointmentsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MyAppointmentsStateInitial implements MyAppointmentsState {
  const factory MyAppointmentsStateInitial() = _$MyAppointmentsStateInitialImpl;
}

/// @nodoc
abstract class _$$MyAppointmentsStateLoadingImplCopyWith<$Res> {
  factory _$$MyAppointmentsStateLoadingImplCopyWith(
          _$MyAppointmentsStateLoadingImpl value,
          $Res Function(_$MyAppointmentsStateLoadingImpl) then) =
      __$$MyAppointmentsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MyAppointmentsStateLoadingImplCopyWithImpl<$Res>
    extends _$MyAppointmentsStateCopyWithImpl<$Res,
        _$MyAppointmentsStateLoadingImpl>
    implements _$$MyAppointmentsStateLoadingImplCopyWith<$Res> {
  __$$MyAppointmentsStateLoadingImplCopyWithImpl(
      _$MyAppointmentsStateLoadingImpl _value,
      $Res Function(_$MyAppointmentsStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MyAppointmentsStateLoadingImpl implements MyAppointmentsStateLoading {
  const _$MyAppointmentsStateLoadingImpl();

  @override
  String toString() {
    return 'MyAppointmentsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyAppointmentsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
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
    required TResult Function(MyAppointmentsStateInitial value) initial,
    required TResult Function(MyAppointmentsStateLoading value) loading,
    required TResult Function(MyAppointmentsStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyAppointmentsStateInitial value)? initial,
    TResult? Function(MyAppointmentsStateLoading value)? loading,
    TResult? Function(MyAppointmentsStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyAppointmentsStateInitial value)? initial,
    TResult Function(MyAppointmentsStateLoading value)? loading,
    TResult Function(MyAppointmentsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MyAppointmentsStateLoading implements MyAppointmentsState {
  const factory MyAppointmentsStateLoading() = _$MyAppointmentsStateLoadingImpl;
}

/// @nodoc
abstract class _$$MyAppointmentsStateLoadedImplCopyWith<$Res> {
  factory _$$MyAppointmentsStateLoadedImplCopyWith(
          _$MyAppointmentsStateLoadedImpl value,
          $Res Function(_$MyAppointmentsStateLoadedImpl) then) =
      __$$MyAppointmentsStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> appointments, bool isRefreshLoader});
}

/// @nodoc
class __$$MyAppointmentsStateLoadedImplCopyWithImpl<$Res>
    extends _$MyAppointmentsStateCopyWithImpl<$Res,
        _$MyAppointmentsStateLoadedImpl>
    implements _$$MyAppointmentsStateLoadedImplCopyWith<$Res> {
  __$$MyAppointmentsStateLoadedImplCopyWithImpl(
      _$MyAppointmentsStateLoadedImpl _value,
      $Res Function(_$MyAppointmentsStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? isRefreshLoader = null,
  }) {
    return _then(_$MyAppointmentsStateLoadedImpl(
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

class _$MyAppointmentsStateLoadedImpl implements MyAppointmentsStateLoaded {
  const _$MyAppointmentsStateLoadedImpl(
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
    return 'MyAppointmentsState.loaded(appointments: $appointments, isRefreshLoader: $isRefreshLoader)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyAppointmentsStateLoadedImpl &&
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
  _$$MyAppointmentsStateLoadedImplCopyWith<_$MyAppointmentsStateLoadedImpl>
      get copyWith => __$$MyAppointmentsStateLoadedImplCopyWithImpl<
          _$MyAppointmentsStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<String> appointments, bool isRefreshLoader)
        loaded,
  }) {
    return loaded(appointments, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<String> appointments, bool isRefreshLoader)? loaded,
  }) {
    return loaded?.call(appointments, isRefreshLoader);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<String> appointments, bool isRefreshLoader)? loaded,
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
    required TResult Function(MyAppointmentsStateInitial value) initial,
    required TResult Function(MyAppointmentsStateLoading value) loading,
    required TResult Function(MyAppointmentsStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyAppointmentsStateInitial value)? initial,
    TResult? Function(MyAppointmentsStateLoading value)? loading,
    TResult? Function(MyAppointmentsStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyAppointmentsStateInitial value)? initial,
    TResult Function(MyAppointmentsStateLoading value)? loading,
    TResult Function(MyAppointmentsStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MyAppointmentsStateLoaded implements MyAppointmentsState {
  const factory MyAppointmentsStateLoaded(
          final List<String> appointments, final bool isRefreshLoader) =
      _$MyAppointmentsStateLoadedImpl;

  List<String> get appointments;
  bool get isRefreshLoader;
  @JsonKey(ignore: true)
  _$$MyAppointmentsStateLoadedImplCopyWith<_$MyAppointmentsStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<dynamic>? listings) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<dynamic>? listings)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<dynamic>? listings)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestStateInitial value) initial,
    required TResult Function(TestStateLoading value) loading,
    required TResult Function(TestStateLoaded value) loaded,
    required TResult Function(TestStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestStateInitial value)? initial,
    TResult? Function(TestStateLoading value)? loading,
    TResult? Function(TestStateLoaded value)? loaded,
    TResult? Function(TestStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestStateInitial value)? initial,
    TResult Function(TestStateLoading value)? loading,
    TResult Function(TestStateLoaded value)? loaded,
    TResult Function(TestStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestStateCopyWith<$Res> {
  factory $TestStateCopyWith(TestState value, $Res Function(TestState) then) =
      _$TestStateCopyWithImpl<$Res, TestState>;
}

/// @nodoc
class _$TestStateCopyWithImpl<$Res, $Val extends TestState>
    implements $TestStateCopyWith<$Res> {
  _$TestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestStateInitialCopyWith<$Res> {
  factory _$$TestStateInitialCopyWith(
          _$TestStateInitial value, $Res Function(_$TestStateInitial) then) =
      __$$TestStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestStateInitialCopyWithImpl<$Res>
    extends _$TestStateCopyWithImpl<$Res, _$TestStateInitial>
    implements _$$TestStateInitialCopyWith<$Res> {
  __$$TestStateInitialCopyWithImpl(
      _$TestStateInitial _value, $Res Function(_$TestStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestStateInitial implements TestStateInitial {
  const _$TestStateInitial();

  @override
  String toString() {
    return 'TestState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<dynamic>? listings) loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<dynamic>? listings)? loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<dynamic>? listings)? loaded,
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
    required TResult Function(TestStateInitial value) initial,
    required TResult Function(TestStateLoading value) loading,
    required TResult Function(TestStateLoaded value) loaded,
    required TResult Function(TestStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestStateInitial value)? initial,
    TResult? Function(TestStateLoading value)? loading,
    TResult? Function(TestStateLoaded value)? loaded,
    TResult? Function(TestStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestStateInitial value)? initial,
    TResult Function(TestStateLoading value)? loading,
    TResult Function(TestStateLoaded value)? loaded,
    TResult Function(TestStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TestStateInitial implements TestState {
  const factory TestStateInitial() = _$TestStateInitial;
}

/// @nodoc
abstract class _$$TestStateLoadingCopyWith<$Res> {
  factory _$$TestStateLoadingCopyWith(
          _$TestStateLoading value, $Res Function(_$TestStateLoading) then) =
      __$$TestStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestStateLoadingCopyWithImpl<$Res>
    extends _$TestStateCopyWithImpl<$Res, _$TestStateLoading>
    implements _$$TestStateLoadingCopyWith<$Res> {
  __$$TestStateLoadingCopyWithImpl(
      _$TestStateLoading _value, $Res Function(_$TestStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestStateLoading implements TestStateLoading {
  const _$TestStateLoading();

  @override
  String toString() {
    return 'TestState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<dynamic>? listings) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<dynamic>? listings)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<dynamic>? listings)? loaded,
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
    required TResult Function(TestStateInitial value) initial,
    required TResult Function(TestStateLoading value) loading,
    required TResult Function(TestStateLoaded value) loaded,
    required TResult Function(TestStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestStateInitial value)? initial,
    TResult? Function(TestStateLoading value)? loading,
    TResult? Function(TestStateLoaded value)? loaded,
    TResult? Function(TestStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestStateInitial value)? initial,
    TResult Function(TestStateLoading value)? loading,
    TResult Function(TestStateLoaded value)? loaded,
    TResult Function(TestStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TestStateLoading implements TestState {
  const factory TestStateLoading() = _$TestStateLoading;
}

/// @nodoc
abstract class _$$TestStateLoadedCopyWith<$Res> {
  factory _$$TestStateLoadedCopyWith(
          _$TestStateLoaded value, $Res Function(_$TestStateLoaded) then) =
      __$$TestStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<dynamic>? listings});
}

/// @nodoc
class __$$TestStateLoadedCopyWithImpl<$Res>
    extends _$TestStateCopyWithImpl<$Res, _$TestStateLoaded>
    implements _$$TestStateLoadedCopyWith<$Res> {
  __$$TestStateLoadedCopyWithImpl(
      _$TestStateLoaded _value, $Res Function(_$TestStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listings = freezed,
  }) {
    return _then(_$TestStateLoaded(
      freezed == listings
          ? _value._listings
          : listings // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

class _$TestStateLoaded implements TestStateLoaded {
  const _$TestStateLoaded(final List<dynamic>? listings) : _listings = listings;

  final List<dynamic>? _listings;
  @override
  List<dynamic>? get listings {
    final value = _listings;
    if (value == null) return null;
    if (_listings is EqualUnmodifiableListView) return _listings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TestState.loaded(listings: $listings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestStateLoaded &&
            const DeepCollectionEquality().equals(other._listings, _listings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_listings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestStateLoadedCopyWith<_$TestStateLoaded> get copyWith =>
      __$$TestStateLoadedCopyWithImpl<_$TestStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<dynamic>? listings) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(listings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<dynamic>? listings)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(listings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<dynamic>? listings)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(listings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestStateInitial value) initial,
    required TResult Function(TestStateLoading value) loading,
    required TResult Function(TestStateLoaded value) loaded,
    required TResult Function(TestStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestStateInitial value)? initial,
    TResult? Function(TestStateLoading value)? loading,
    TResult? Function(TestStateLoaded value)? loaded,
    TResult? Function(TestStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestStateInitial value)? initial,
    TResult Function(TestStateLoading value)? loading,
    TResult Function(TestStateLoaded value)? loaded,
    TResult Function(TestStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TestStateLoaded implements TestState {
  const factory TestStateLoaded(final List<dynamic>? listings) =
      _$TestStateLoaded;

  List<dynamic>? get listings;
  @JsonKey(ignore: true)
  _$$TestStateLoadedCopyWith<_$TestStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestStateErrorCopyWith<$Res> {
  factory _$$TestStateErrorCopyWith(
          _$TestStateError value, $Res Function(_$TestStateError) then) =
      __$$TestStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$TestStateErrorCopyWithImpl<$Res>
    extends _$TestStateCopyWithImpl<$Res, _$TestStateError>
    implements _$$TestStateErrorCopyWith<$Res> {
  __$$TestStateErrorCopyWithImpl(
      _$TestStateError _value, $Res Function(_$TestStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$TestStateError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TestStateError implements TestStateError {
  const _$TestStateError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'TestState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestStateErrorCopyWith<_$TestStateError> get copyWith =>
      __$$TestStateErrorCopyWithImpl<_$TestStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<dynamic>? listings) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<dynamic>? listings)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<dynamic>? listings)? loaded,
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
    required TResult Function(TestStateInitial value) initial,
    required TResult Function(TestStateLoading value) loading,
    required TResult Function(TestStateLoaded value) loaded,
    required TResult Function(TestStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestStateInitial value)? initial,
    TResult? Function(TestStateLoading value)? loading,
    TResult? Function(TestStateLoaded value)? loaded,
    TResult? Function(TestStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestStateInitial value)? initial,
    TResult Function(TestStateLoading value)? loading,
    TResult Function(TestStateLoaded value)? loaded,
    TResult Function(TestStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TestStateError implements TestState {
  const factory TestStateError(final String error) = _$TestStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$TestStateErrorCopyWith<_$TestStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

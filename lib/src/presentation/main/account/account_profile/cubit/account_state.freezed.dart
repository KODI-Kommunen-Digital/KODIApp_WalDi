// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(AccountError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(AccountError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(AccountError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
          AccountState value, $Res Function(AccountState) then) =
      _$AccountStateCopyWithImpl<$Res, AccountState>;
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

// ignore: unused_field
  final $Val _value;
// ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AccountLoadingCopyWith<$Res> {
  factory _$$AccountLoadingCopyWith(
          _$AccountLoading value, $Res Function(_$AccountLoading) then) =
      __$$AccountLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountLoadingCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountLoading>
    implements _$$AccountLoadingCopyWith<$Res> {
  __$$AccountLoadingCopyWithImpl(
      _$AccountLoading _value, $Res Function(_$AccountLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AccountLoading implements AccountLoading {
  const _$AccountLoading();

  @override
  String toString() {
    return 'AccountState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String errorMessage)? error,
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
    required TResult Function(AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(AccountError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(AccountError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(AccountError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AccountLoading implements AccountState {
  const factory AccountLoading() = _$AccountLoading;
}

/// @nodoc
abstract class _$$AccountLoadedCopyWith<$Res> {
  factory _$$AccountLoadedCopyWith(
          _$AccountLoaded value, $Res Function(_$AccountLoaded) then) =
      __$$AccountLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountLoadedCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountLoaded>
    implements _$$AccountLoadedCopyWith<$Res> {
  __$$AccountLoadedCopyWithImpl(
      _$AccountLoaded _value, $Res Function(_$AccountLoaded) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AccountLoaded implements AccountLoaded {
  const _$AccountLoaded();

  @override
  String toString() {
    return 'AccountState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(AccountError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(AccountError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(AccountError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AccountLoaded implements AccountState {
  const factory AccountLoaded() = _$AccountLoaded;
}

/// @nodoc
abstract class _$$AccountErrorCopyWith<$Res> {
  factory _$$AccountErrorCopyWith(
          _$AccountError value, $Res Function(_$AccountError) then) =
      __$$AccountErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$AccountErrorCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountError>
    implements _$$AccountErrorCopyWith<$Res> {
  __$$AccountErrorCopyWithImpl(
      _$AccountError _value, $Res Function(_$AccountError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$AccountError(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountError implements AccountError {
  const _$AccountError(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AccountState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountError &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountErrorCopyWith<_$AccountError> get copyWith =>
      __$$AccountErrorCopyWithImpl<_$AccountError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountLoading value) loading,
    required TResult Function(AccountLoaded value) loaded,
    required TResult Function(AccountError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountLoading value)? loading,
    TResult? Function(AccountLoaded value)? loaded,
    TResult? Function(AccountError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountLoading value)? loading,
    TResult Function(AccountLoaded value)? loaded,
    TResult Function(AccountError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AccountError implements AccountState {
  const factory AccountError(final String errorMessage) = _$AccountError;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$AccountErrorCopyWith<_$AccountError> get copyWith =>
      throw _privateConstructorUsedError;
}

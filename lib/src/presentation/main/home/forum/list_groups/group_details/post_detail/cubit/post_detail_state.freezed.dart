// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostDetailInitial value) initial,
    required TResult Function(PostDetailLoading value) loading,
    required TResult Function(PostDetailLoaded value) loaded,
    required TResult Function(PostDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostDetailInitial value)? initial,
    TResult? Function(PostDetailLoading value)? loading,
    TResult? Function(PostDetailLoaded value)? loaded,
    TResult? Function(PostDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostDetailInitial value)? initial,
    TResult Function(PostDetailLoading value)? loading,
    TResult Function(PostDetailLoaded value)? loaded,
    TResult Function(PostDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailStateCopyWith<$Res> {
  factory $PostDetailStateCopyWith(
          PostDetailState value, $Res Function(PostDetailState) then) =
      _$PostDetailStateCopyWithImpl<$Res, PostDetailState>;
}

/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res, $Val extends PostDetailState>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PostDetailInitialCopyWith<$Res> {
  factory _$$PostDetailInitialCopyWith(
          _$PostDetailInitial value, $Res Function(_$PostDetailInitial) then) =
      __$$PostDetailInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostDetailInitialCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailInitial>
    implements _$$PostDetailInitialCopyWith<$Res> {
  __$$PostDetailInitialCopyWithImpl(
      _$PostDetailInitial _value, $Res Function(_$PostDetailInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostDetailInitial implements PostDetailInitial {
  const _$PostDetailInitial();

  @override
  String toString() {
    return 'PostDetailState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostDetailInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)
        loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
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
    required TResult Function(PostDetailInitial value) initial,
    required TResult Function(PostDetailLoading value) loading,
    required TResult Function(PostDetailLoaded value) loaded,
    required TResult Function(PostDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostDetailInitial value)? initial,
    TResult? Function(PostDetailLoading value)? loading,
    TResult? Function(PostDetailLoaded value)? loaded,
    TResult? Function(PostDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostDetailInitial value)? initial,
    TResult Function(PostDetailLoading value)? loading,
    TResult Function(PostDetailLoaded value)? loaded,
    TResult Function(PostDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PostDetailInitial implements PostDetailState {
  const factory PostDetailInitial() = _$PostDetailInitial;
}

/// @nodoc
abstract class _$$PostDetailLoadingCopyWith<$Res> {
  factory _$$PostDetailLoadingCopyWith(
          _$PostDetailLoading value, $Res Function(_$PostDetailLoading) then) =
      __$$PostDetailLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostDetailLoadingCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailLoading>
    implements _$$PostDetailLoadingCopyWith<$Res> {
  __$$PostDetailLoadingCopyWithImpl(
      _$PostDetailLoading _value, $Res Function(_$PostDetailLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostDetailLoading implements PostDetailLoading {
  const _$PostDetailLoading();

  @override
  String toString() {
    return 'PostDetailState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostDetailLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
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
    required TResult Function(PostDetailInitial value) initial,
    required TResult Function(PostDetailLoading value) loading,
    required TResult Function(PostDetailLoaded value) loaded,
    required TResult Function(PostDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostDetailInitial value)? initial,
    TResult? Function(PostDetailLoading value)? loading,
    TResult? Function(PostDetailLoaded value)? loaded,
    TResult? Function(PostDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostDetailInitial value)? initial,
    TResult Function(PostDetailLoading value)? loading,
    TResult Function(PostDetailLoaded value)? loaded,
    TResult Function(PostDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PostDetailLoading implements PostDetailState {
  const factory PostDetailLoading() = _$PostDetailLoading;
}

/// @nodoc
abstract class _$$PostDetailLoadedCopyWith<$Res> {
  factory _$$PostDetailLoadedCopyWith(
          _$PostDetailLoaded value, $Res Function(_$PostDetailLoaded) then) =
      __$$PostDetailLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {UserModel? userDetail, String userImage, int userId, bool isAdmin});
}

/// @nodoc
class __$$PostDetailLoadedCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailLoaded>
    implements _$$PostDetailLoadedCopyWith<$Res> {
  __$$PostDetailLoadedCopyWithImpl(
      _$PostDetailLoaded _value, $Res Function(_$PostDetailLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userDetail = freezed,
    Object? userImage = null,
    Object? userId = null,
    Object? isAdmin = null,
  }) {
    return _then(_$PostDetailLoaded(
      freezed == userDetail
          ? _value.userDetail
          : userDetail // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      null == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PostDetailLoaded implements PostDetailLoaded {
  const _$PostDetailLoaded(
      this.userDetail, this.userImage, this.userId, this.isAdmin);

  @override
  final UserModel? userDetail;
  @override
  final String userImage;
  @override
  final int userId;
  @override
  final bool isAdmin;

  @override
  String toString() {
    return 'PostDetailState.loaded(userDetail: $userDetail, userImage: $userImage, userId: $userId, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailLoaded &&
            (identical(other.userDetail, userDetail) ||
                other.userDetail == userDetail) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userDetail, userImage, userId, isAdmin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailLoadedCopyWith<_$PostDetailLoaded> get copyWith =>
      __$$PostDetailLoadedCopyWithImpl<_$PostDetailLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(userDetail, userImage, userId, isAdmin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(userDetail, userImage, userId, isAdmin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(userDetail, userImage, userId, isAdmin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostDetailInitial value) initial,
    required TResult Function(PostDetailLoading value) loading,
    required TResult Function(PostDetailLoaded value) loaded,
    required TResult Function(PostDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostDetailInitial value)? initial,
    TResult? Function(PostDetailLoading value)? loading,
    TResult? Function(PostDetailLoaded value)? loaded,
    TResult? Function(PostDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostDetailInitial value)? initial,
    TResult Function(PostDetailLoading value)? loading,
    TResult Function(PostDetailLoaded value)? loaded,
    TResult Function(PostDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PostDetailLoaded implements PostDetailState {
  const factory PostDetailLoaded(
      final UserModel? userDetail,
      final String userImage,
      final int userId,
      final bool isAdmin) = _$PostDetailLoaded;

  UserModel? get userDetail;
  String get userImage;
  int get userId;
  bool get isAdmin;
  @JsonKey(ignore: true)
  _$$PostDetailLoadedCopyWith<_$PostDetailLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostDetailErrorCopyWith<$Res> {
  factory _$$PostDetailErrorCopyWith(
          _$PostDetailError value, $Res Function(_$PostDetailError) then) =
      __$$PostDetailErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$PostDetailErrorCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailError>
    implements _$$PostDetailErrorCopyWith<$Res> {
  __$$PostDetailErrorCopyWithImpl(
      _$PostDetailError _value, $Res Function(_$PostDetailError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$PostDetailError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostDetailError implements PostDetailError {
  const _$PostDetailError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'PostDetailState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailErrorCopyWith<_$PostDetailError> get copyWith =>
      __$$PostDetailErrorCopyWithImpl<_$PostDetailError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            UserModel? userDetail, String userImage, int userId, bool isAdmin)?
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
    required TResult Function(PostDetailInitial value) initial,
    required TResult Function(PostDetailLoading value) loading,
    required TResult Function(PostDetailLoaded value) loaded,
    required TResult Function(PostDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostDetailInitial value)? initial,
    TResult? Function(PostDetailLoading value)? loading,
    TResult? Function(PostDetailLoaded value)? loaded,
    TResult? Function(PostDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostDetailInitial value)? initial,
    TResult Function(PostDetailLoading value)? loading,
    TResult Function(PostDetailLoaded value)? loaded,
    TResult Function(PostDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PostDetailError implements PostDetailState {
  const factory PostDetailError(final String error) = _$PostDetailError;

  String get error;
  @JsonKey(ignore: true)
  _$$PostDetailErrorCopyWith<_$PostDetailError> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.loading() = ChangePasswordStateLoading;

  const factory ChangePasswordState.loaded() = ChangePasswordStateLoaded;

  const factory ChangePasswordState.error() = ChangePasswordStateError;
}

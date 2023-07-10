import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.loading() = ForgotPasswordStateLoading;

  const factory ForgotPasswordState.loaded() = ForgotPasswordStateLoaded;

  const factory ForgotPasswordState.error() = ForgotPasswordStateError;
}

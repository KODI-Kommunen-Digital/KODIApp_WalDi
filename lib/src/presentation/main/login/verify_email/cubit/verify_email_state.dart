import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_state.freezed.dart';

@freezed
class VerifyEmailState with _$VerifyEmailState {
  const factory VerifyEmailState.loading() = VerifyEmailStateLoading;

  const factory VerifyEmailState.loaded() = VerifyEmailStateLoaded;

  const factory VerifyEmailState.error(String msg) = VerifyEmailStateError;
}

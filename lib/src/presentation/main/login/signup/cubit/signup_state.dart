import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.loading() = SignUpStateLoading;

  const factory SignUpState.loaded() = SignUpStateLoaded;

  const factory SignUpState.error() = SignUpStateError;
}

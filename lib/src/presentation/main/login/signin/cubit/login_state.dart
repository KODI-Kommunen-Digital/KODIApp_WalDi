import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.loading() = LoginStateLoading;

  const factory LoginState.loaded() = LoginStateLoaded;

  const factory LoginState.error() = LoginStateError;
}

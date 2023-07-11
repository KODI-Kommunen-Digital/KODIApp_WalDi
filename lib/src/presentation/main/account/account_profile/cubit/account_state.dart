import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {

  const factory AccountState.loading() = AccountLoading;

  const factory AccountState.loaded() = AccountLoaded;

  const factory AccountState.error(String errorMessage) = AccountError;
}

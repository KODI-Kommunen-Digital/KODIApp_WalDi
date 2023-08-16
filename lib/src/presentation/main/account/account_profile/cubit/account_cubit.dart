import 'package:bloc/bloc.dart';

import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const AccountState.loading()) {
    getLoginDetail();
  }

  Future<void> getLoginDetail() async {
    emit(const AccountState.loaded());
  }
}

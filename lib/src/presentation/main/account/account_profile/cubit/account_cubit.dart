import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const AccountState.loading()) {
    getLoginDetail();
  }

  Future<void> getLoginDetail() async {
    emit(const AccountState.loaded());
  }

  Future<bool> deleteUserAccount() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, '');
    final response = await Api.deleteUserAccount(userId);
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }
}

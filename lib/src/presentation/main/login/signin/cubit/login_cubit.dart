import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

enum LoginState {
  init,
  loading,
  success,
  fail,
}

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginState.init);

  void onLogin({
    required String username,
    required String password,
  }) async {
    ///Notify
    emit(LoginState.loading);

    ///Set Device Token
    // Application.device?.token = await Utils.getDeviceToken();

    ///login via repository

    final result = await UserRepository.login(
      username: username,
      password: password,
    );




    if (result != null) {
      logError('LoginResult', result.email);
      // ///Begin start Auth flow
      // await AppBloc.authenticateCubit.onSave(result);
      //
      // ///Notify
      // emit(LoginState.success);
    } else {
      logError('LoginResultFailed');
      ///Notify
      // emit(LoginState.fail);
    }
  }

  void onLogout() async {
    ///Begin start auth flow
    final prefs = await Preferences.openBox();
    emit(LoginState.init);
    prefs.deleteKey(Preferences.userId);
    AppBloc.authenticateCubit.onClear();
    AppBloc.userCubit.onDeleteUser();
  }
//
// void onDeactivate() async {
//   final result = await UserRepository.deactivate();
//   if (result) {
//     AppBloc.authenticateCubit.onClear();
//   }
// }
}

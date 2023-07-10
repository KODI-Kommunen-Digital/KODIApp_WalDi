import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(const LoginState.loaded());

  void onLogin({
    required String username,
    required String password,
  }) async {
    emit(const LoginState.loading());

    final result = await UserRepository.login(
      username: username,
      password: password,
    );

    if (result != null) {
      await AppBloc.authenticateCubit.onSave(result);

      emit(const LoginState.loaded());
    } else {
      logError('LoginResultFailed');
      ///Notify
      emit(const LoginState.error());
    }
  }

  void onLogout() async {
    final prefs = await Preferences.openBox();
    prefs.deleteKey(Preferences.userId);
    AppBloc.authenticateCubit.onClear();
    AppBloc.userCubit.onDeleteUser();
  }
}

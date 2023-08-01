import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  void onLogin({
    required String username,
    required String password,
  }) async {
    final response = await UserRepository.login(
      username: username,
      password: password,
    );
    if (response!.success) {
      final userDetailResponse =
          await UserRepository.requestUserDetails(response.data['userId']);
      if (userDetailResponse != null) {
        await AppBloc.authenticateCubit.onSave(userDetailResponse);

        emit(const LoginState.loaded());
      } else {
        emit(const LoginState.initial());
        logError('Login Result Failed', userDetailResponse);
      }
    } else {
      emit(const LoginState.initial());
      emit(LoginState.error(response.message));
      logError('Request User Detail Error', response.message);
    }
  }

  String? getTranslationKey(String sentence) {
    switch (sentence) {
      case "Invalid username":
        return "login_invalid_username";
      case "Invalid password":
        return "login_invalid_password";
      case "Verification email sent to your email id. Please verify first before trying to login.":
        return "login_verification_mail";
    }
    return null;
  }

  void onLogout() async {
    emit(const LoginState.initial());
    final prefs = await Preferences.openBox();
    prefs.deleteKey(Preferences.userId);
    AppBloc.authenticateCubit.onClear();
    AppBloc.userCubit.onDeleteUser();
  }
}

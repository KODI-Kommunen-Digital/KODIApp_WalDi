import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/login/signup/cubit/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit() : super(const SignUpState.loading());

Future<bool> onRegister({
  required String firstname,
  required String lastname,
  required String username,
  required String password,
  required String confirmPassword,
  required String email,
  required String role,
}) async {
  return await UserRepository.register(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      firstname: firstname,
      lastname: lastname,
      role: "3");
}

///Event forgot password
Future<bool> onForgotPassword(String username) async {
  return await UserRepository.forgotPassword(username: username);
}
}
import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/login/forgot_password/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>{

  ForgotPasswordCubit() : super(const ForgotPasswordStateLoading());

  Future<ResultApiModel> onForgotPassword(String username) async {
    return await UserRepository.forgotPassword(username: username);
  }
}
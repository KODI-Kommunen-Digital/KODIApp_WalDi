import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/account/change_password/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState.loading());

  Future<bool> onChangePassword(
      String currentPassword, String newPassword, String? link) async {
    return await UserRepository.changePassword(
        currentPassword: currentPassword, password: newPassword, link: link);
  }
}

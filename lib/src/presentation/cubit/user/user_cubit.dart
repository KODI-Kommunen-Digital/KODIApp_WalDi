import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  Future<UserModel?> onLoadUser() async {
    UserModel? user = await UserRepository.loadUser();
    emit(user);
    return user;
  }

  Future<UserModel?> onFetchUser() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    UserModel? local = await UserRepository.loadUser();
    UserModel? remote = await UserRepository.fetchUser(userId);
    if (local != null && remote != null) {
      final sync = local.updateUser(
        username: remote.username,
        firstname: remote.firstname,
        lastname: remote.lastname,
        email: remote.email,
        url: remote.url,
        description: remote.description,
        image: remote.image,
      );
      onSaveUser(sync);
      return sync;
    }
    return null;
  }

  Future<void> onSaveUser(UserModel user) async {
    await UserRepository.saveUser(user: user);
    emit(user);
  }

  void onDeleteUser() {
    UserRepository.deleteUser();
    emit(null);
  }
}

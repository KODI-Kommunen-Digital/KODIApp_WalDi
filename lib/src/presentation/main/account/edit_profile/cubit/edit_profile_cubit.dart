import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState>{

  EditProfileCubit() : super(const EditProfileState.loading());

  Future<bool> onUpdateUser({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String url,
    required String description,
    String? image,
  }) async {
    final result = await UserRepository.changeProfile(
      username: username,
      firstname: firstname,
      lastname: lastname,
      email: email,
      url: url,
      description: description,
      image: image,
    );

    if (result) {
      await AppBloc.userCubit.onFetchUser();
    }
    return result;
  }

  // Future<UserModel?> onFetchUser(userId) async {
  //
  //   UserModel? local = await UserRepository.loadUser();
  //   UserModel? remote = await UserRepository.fetchUser(userId);
  //   if (local != null && remote != null) {
  //     final sync = local.updateUser(
  //       username: remote.username,
  //       firstname: remote.firstname,
  //       lastname: remote.lastname,
  //       email: remote.email,
  //       url: remote.url,
  //       description: remote.description,
  //       image: remote.image,
  //     );
  //     onSaveUser(sync);
  //     return sync;
  //   }
  //   return null;
  // }
  //
  // Future<void> onSaveUser(UserModel user) async {
  //   await UserRepository.saveUser(user: user);
  //   emit(user);
  // }

}
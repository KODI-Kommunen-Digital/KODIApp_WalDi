import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
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
    final changeProfileResponse = await UserRepository.changeProfile(
      username: username,
      firstname: firstname,
      lastname: lastname,
      email: email,
      url: url,
      description: description,
      image: image,
    );

    if (changeProfileResponse) {
      await AppBloc.userCubit.onFetchUser();
      await AppBloc.userCubit.onLoadUser();
    }
    return changeProfileResponse;
  }

  UserModel getUserDetails() {
    return AppBloc.userCubit.state!;
  }
}

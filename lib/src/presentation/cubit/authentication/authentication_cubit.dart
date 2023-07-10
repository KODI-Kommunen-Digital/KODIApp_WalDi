import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/authentication_state.dart';
import 'package:heidi/src/utils/logger.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.loading());

  Future<void> onCheck() async {
    emit(const AuthenticationState.loading());

    ///Event load user
    UserModel? user = await AppBloc.userCubit.onLoadUser();

    UtilLogger.log('UserResult', user);
    if (user != null) {
      ///Attach token push
      // Application.device?.token = await Utils.getDeviceToken();

      ///Save user
      // await AppBloc.userCubit.onSaveUser(user);

      // AppBloc.wishListCubit.onLoad();

      ///Fetch user
      AppBloc.userCubit.onFetchUser();

      ///Notify
      emit(const AuthenticationState.loaded());
      AppBloc.userCubit.onFetchUser();
    } else {
      ///Notify
      emit(const AuthenticationState.failed());
    }
  }

  Future<void> onSave(UserModel user) async {
    emit(const AuthenticationState.loading());
    Api.requestUser(userId: user.id);

    await AppBloc.userCubit.onSaveUser(user);

    ///Load wishList
    // AppBloc.wishListCubit.onLoad();

    emit(const AuthenticationState.loaded());
  }

  Future<void> onClear() async {

    emit(const AuthenticationState.failed());
    emit(const AuthenticationState.loggedOut());
  }
}

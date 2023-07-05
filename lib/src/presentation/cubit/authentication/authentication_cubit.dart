import 'package:bloc/bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.loading());

  Future<void> onCheck() async {

    emit(const AuthenticationState.loading());

    ///Event load user
    // UserModel? user = await AppBloc.userCubit.onLoadUser();
    //
    // if (user != null) {
    //   ///Attach token push
    //   // Application.device?.token = await Utils.getDeviceToken();
    //
    //   ///Save user
    //   // await AppBloc.userCubit.onSaveUser(user);
    //
    //   AppBloc.wishListCubit.onLoad();
    //
    //   ///Fetch user
    //   AppBloc.userCubit.onFetchUser();
    //
    //   ///Notify
    //   emit(const AuthenticationState.loaded());
    //
    //   ///Valid token server
    //   // final result = await UserRepository.validateToken();
    //
    //   // if (result) {
    //   //   ///Load wishList
    //   //   AppBloc.wishListCubit.onLoad();
    //
    //   //   ///Fetch user
    //   AppBloc.userCubit.onFetchUser();

      //   ///Notify
      //   emit(AuthenticationState.success);
      // } else {
      //   ///Logout
      //   onClear();
      // }
    // } else {
    //   ///Notify
    //   emit(const AuthenticationState.failed());
    // }
  }

  // Future<void> onSave(UserModel user) async {
  //   ///Notify
  //   emit(const AuthenticationState.loading());
  //   Api.requestUser(userId: user.id);
  //
  //   ///Event Save user
  //   await AppBloc.userCubit.onSaveUser(user);
  //
  //   ///Load wishList
  //   AppBloc.wishListCubit.onLoad();
  //
  //   /// Notify
  //   emit(const AuthenticationState.loaded());
  // }

  Future<void> onClear() async {
    /// Notify

    emit(const AuthenticationState.failed());
    emit(const AuthenticationState.loggedOut());

    ///Delete user
    // AppBloc.userCubit.onDeleteUser();
  }
}

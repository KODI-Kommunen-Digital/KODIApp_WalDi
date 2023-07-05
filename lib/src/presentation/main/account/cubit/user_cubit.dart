import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_user.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  // Future<Object?> getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.get('userId');
  // }
  //
  // ///Event load user
  // Future<UserModel?> onLoadUser() async {
  //   UserModel? user = await UserRepository.loadUser();
  //   emit(user);
  //   return user;
  // }
  //
  // ///Event fetch user
  // Future<UserModel?> onFetchUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getInt('userId');
  //   UserModel? local = await UserRepository.loadUser();
  //   UserModel? remote = await UserRepository.fetchUser(userId);
  //   if (local != null && remote != null) {
  //     final sync = local.updateUser(
  //       username: remote.username,
  //       firstname: remote.firstname,
  //       lastname: remote.lastname,
  //       // name: remote.name,
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
  // ///Event save user
  // Future<void> onSaveUser(UserModel user) async {
  //   await UserRepository.saveUser(user: user);
  //   emit(user);
  // }
  //
  // ///Event delete user
  // void onDeleteUser() {
  //   // FirebaseMessaging.instance.deleteToken();
  //   UserRepository.deleteUser();
  //   emit(null);
  // }
  //
  // ///Event update user
  // Future<bool> onUpdateUser({
  //   required String username,
  //   required String firstname,
  //   required String lastname,
  //   required String email,
  //   required String url,
  //   required String description,
  //   String? image,
  // }) async {
  //   ///Fetch change profile
  //   final result = await UserRepository.changeProfile(
  //     username: username,
  //     firstname: firstname,
  //     lastname: lastname,
  //     email: email,
  //     url: url,
  //     description: description,
  //     image: image,
  //   );
  //
  //   ///Case success
  //   if (result) {
  //     await onFetchUser();
  //   }
  //   return result;
  // }
  //
  // ///Event change password
  // Future<bool> onChangePassword(
  //     String currentPassword, String newPassword) async {
  //   return await UserRepository.changePassword(
  //       currentPassword: currentPassword, password: newPassword);
  // }
  //
  // ///Event register
  // Future<bool> onRegister({
  //   required String firstname,
  //   required String lastname,
  //   required String username,
  //   required String password,
  //   required String confirmPassword,
  //   required String email,
  //   required String role,
  // }) async {
  //   return await UserRepository.register(
  //       username: username,
  //       password: password,
  //       confirmPassword: confirmPassword,
  //       email: email,
  //       firstname: firstname,
  //       lastname: lastname,
  //       role: "3");
  // }
  //
  // ///Event forgot password
  // Future<bool> onForgotPassword(String username) async {
  //   return await UserRepository.forgotPassword(username: username);
  // }
}

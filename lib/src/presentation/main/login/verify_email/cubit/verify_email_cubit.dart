import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/login/verify_email/cubit/verify_email_state.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(const VerifyEmailState.loading());

  Future<void> verifyEmail(String link) async {
    Uri uri = Uri.parse(link);
    Map<String, dynamic> params = {
      "language": uri.queryParameters["lang"],
      "token": uri.queryParameters["token"],
      "userId": uri.queryParameters["userId"],
    };

    final response = await Api.requestVerifyEmail(params);
    logError('Change Password Response', response.message);
    if (response.success) {
      emit(const VerifyEmailState.loaded());
    } else {
      emit(VerifyEmailState.error(response.message));
    }
  }
}

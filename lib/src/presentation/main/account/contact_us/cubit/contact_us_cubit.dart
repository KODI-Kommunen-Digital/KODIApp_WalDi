import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/contact_us/cubit/contact_us_state.dart';
import 'package:loggy/loggy.dart';
import '../../../../../data/model/model_user.dart';
import '../../../../cubit/app_bloc.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(const ContactUsState.loading());

  Future<bool> onSendFeedback({
    required String email,
    required String token,
  }) async {
    Map<String, dynamic> params = {"email": email, "token": token};
    final sendFeedback = await Api.contactUs(params);
    if (sendFeedback.success) {
      return true;
    } else {
      logError('save Product Response Failed', sendFeedback.message);
      return false;
    }
  }

  UserModel getUserDetails() {
    return AppBloc.userCubit.state!;
  }
}

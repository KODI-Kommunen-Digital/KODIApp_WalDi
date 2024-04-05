import 'package:bloc/bloc.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit() : super(const AppointmentDetailsState.loading()) {onLoad(false);}

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const AppointmentDetailsState.loading());
    List<String> sampleData = ["Akshay", "Denio", "Saud", "Saud", "Niklas", "Saud"];
    await Future.delayed(const Duration(seconds: 2));
    emit(AppointmentDetailsState.loaded(sampleData, false));
  }
}

import 'package:bloc/bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit() : super(const MyAppointmentsState.loading()) {
    onLoad(false);
  }

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const MyAppointmentsState.loading());
    List<String> sampleData = [
      "Niklas",
      "Justus",
      "Denio",
    ];
    await Future.delayed(const Duration(seconds: 2));
    emit(MyAppointmentsState.loaded(sampleData, false));
  }
}

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit() : super(const MyAppointmentsState.loading()) {
    onLoad(false);
  }

  late AppointmentRepository repo;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const MyAppointmentsState.loading());
      final prefs = await Preferences.openBox();
      repo = AppointmentRepository(prefs);
    }

    List<AppointmentModel>? appointments = await repo.loadUserAppointments(1);
    emit(MyAppointmentsState.loaded(appointments, false));
  }

  Future<void> deleteAppointment(AppointmentModel appointment) async {
    //repo.deleteAppointment(appointment.cityId!, listingId, appointment.id!)
  }
}

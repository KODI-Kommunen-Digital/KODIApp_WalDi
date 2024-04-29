import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

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
    emit(const MyAppointmentsState.loading());
    ProductModel? product = await getProductFromAppointment(appointment.id!);

    if(product != null) {
      bool success = await repo.deleteAppointment(product.cityId ?? 0, product.id, appointment.id!);
      if(success) {
        onLoad(false);
      } else {
        logError("Error deleting appointment");
        emit(const MyAppointmentsState.error("Error deleting appointment"));
      }
    } else {
      emit(const MyAppointmentsState.error("Error deleting appointment"));
    }
  }

  Future<ProductModel?> getProductFromAppointment(int appointmentId) async {
    ProductModel? product = await repo.getProductForAppointment(appointmentId);
    if(product != null) {
      return product;
    }
    logError("Error fetching product for appointment");
    return null;
  }
}

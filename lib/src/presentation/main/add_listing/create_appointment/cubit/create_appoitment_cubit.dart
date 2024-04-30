// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appointment_state.dart';

class CreateAppointmentCubit extends Cubit<CreateAppointmentState> {
  CreateAppointmentCubit() : super(const CreateAppointmentState.loading());

  Future<void> onLoad(ProductModel? product) async {
    emit(const CreateAppointmentState.loading());
    if (product != null) {
      AppointmentModel? appointment =
          await AppointmentRepository.loadAppointment(
              product.cityId!, product.id);
      if (appointment != null) {
        List<AppointmentServiceModel>? services =
            await AppointmentRepository.loadAppointmentServices(
                product.cityId!, product.id, appointment.id!);
        emit(CreateAppointmentState.loaded(services));
      } else {
        emit(const CreateAppointmentState.error("Fail loading Appointment"));
      }
    } else {
      emit(const CreateAppointmentState.loaded(null));
    }
  }
}

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
      try {
        AppointmentModel? appointment =
            await AppointmentRepository.loadAppointment(
                product.cityId!, product.id);
        if (appointment != null) {
          List<AppointmentServiceModel>? services =
              await AppointmentRepository.loadAppointmentServices(
                  product.cityId!, product.id, appointment.id!);
          emit(CreateAppointmentState.loaded(services, appointment));
        } else {
          emit(
              const CreateAppointmentState.error("Failed to load appointment"));
        }
      } catch (e) {
        emit(CreateAppointmentState.error(
            "Error loading appointment: ${e.toString()}"));
      }
    } else {
      List<AppointmentServiceModel> services =
          []; // Example of initializing with an empty list
      AppointmentModel appointment = AppointmentModel(
        id: 0,
        title: '',
        description: '',
        startDate: '',
        openHours: [],
      );
      emit(CreateAppointmentState.loaded(services, appointment));
    }
  }
}

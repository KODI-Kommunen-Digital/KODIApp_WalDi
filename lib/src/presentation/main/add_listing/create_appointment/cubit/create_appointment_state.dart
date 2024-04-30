import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';

part 'create_appointment_state.freezed.dart';

@freezed
class CreateAppointmentState with _$CreateAppointmentState {
  const factory CreateAppointmentState.loading() = CreateAppointmentLoading;

  const factory CreateAppointmentState.loaded(
      List<AppointmentServiceModel>? loadedEntries,
      AppointmentModel appointment) = CreateAppointmentLoaded;

  const factory CreateAppointmentState.error(String error) =
      CreateAppointmentError;
}

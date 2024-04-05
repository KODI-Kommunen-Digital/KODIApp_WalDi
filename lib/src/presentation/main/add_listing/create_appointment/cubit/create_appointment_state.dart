import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_appointment_state.freezed.dart';

@freezed
class CreateAppointmentState with _$CreateAppointmentState {
  const factory CreateAppointmentState.loading() = CreateAppointmentLoading;

  const factory CreateAppointmentState.loaded() = CreateAppointmentLoaded;

  const factory CreateAppointmentState.error(String error) = CreateAppointmentError;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_appointment.dart';

part 'my_appointments_state.freezed.dart';

@freezed
class MyAppointmentsState with _$MyAppointmentsState {
  const factory MyAppointmentsState.initial() = MyAppointmentsStateInitial;

  const factory MyAppointmentsState.loading() = MyAppointmentsStateLoading;

  const factory MyAppointmentsState.loaded(
          List<AppointmentModel>? appointments, bool isRefreshLoader) =
      MyAppointmentsStateLoaded;

  const factory MyAppointmentsState.error(String msg) =
      MyAppointmentsStateError;
}

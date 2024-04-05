import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_appointments_state.freezed.dart';

@freezed
class MyAppointmentsState with _$MyAppointmentsState {
  const factory MyAppointmentsState.initial() = MyAppointmentsStateInitial;

  const factory MyAppointmentsState.loading() = MyAppointmentsStateLoading;

  const factory MyAppointmentsState.loaded(
      List<String> appointments, bool isRefreshLoader) = MyAppointmentsStateLoaded;
}

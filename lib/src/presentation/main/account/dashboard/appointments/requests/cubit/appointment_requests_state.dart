import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_requests_state.freezed.dart';

@freezed
class AppointmentRequestsState with _$AppointmentRequestsState {
  const factory AppointmentRequestsState.loading() = AppointmentRequestsStateLoading;

  const factory AppointmentRequestsState.loaded( List<String> appointments, bool isRefreshLoader) = AppointmentRequestsStateLoaded;

  const factory AppointmentRequestsState.error(String error) = AppointmentRequestsStateError;
}

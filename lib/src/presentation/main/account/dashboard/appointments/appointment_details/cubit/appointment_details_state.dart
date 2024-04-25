import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_booking.dart';

part 'appointment_details_state.freezed.dart';

@freezed
class AppointmentDetailsState with _$AppointmentDetailsState {
  const factory AppointmentDetailsState.initial() = AppointmentDetailsStateInitial;

  const factory AppointmentDetailsState.loading() = AppointmentDetailsStateLoading;

  const factory AppointmentDetailsState.loaded(
      List<BookingModel> bookings, bool isRefreshLoader) = AppointmentDetailsStateLoaded;
}

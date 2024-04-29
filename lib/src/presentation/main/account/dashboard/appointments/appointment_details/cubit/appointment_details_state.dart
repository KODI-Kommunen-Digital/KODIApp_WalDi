import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';

part 'appointment_details_state.freezed.dart';

@freezed
class AppointmentDetailsState with _$AppointmentDetailsState {
  const factory AppointmentDetailsState.initial() =
      AppointmentDetailsStateInitial;

  const factory AppointmentDetailsState.loading() =
      AppointmentDetailsStateLoading;

  const factory AppointmentDetailsState.loaded(
      List<BookingModel> bookings,
      List<BookingGuestModel> guests,
      bool isRefreshLoader) = AppointmentDetailsStateLoaded;

  const factory AppointmentDetailsState.error(String msg) =
      AppointmentDetailsStateError;
}

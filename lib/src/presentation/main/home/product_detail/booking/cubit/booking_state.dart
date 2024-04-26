import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_appointment_slot.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState.loading() = BookingStateLoading;

  const factory BookingState.loaded(List<AppointmentSlotModel>? availableSlots, List<AppointmentServiceModel> services, AppointmentModel appointment) = BookingStateLoaded;

  const factory BookingState.error(String error) = BookingStateError;
}

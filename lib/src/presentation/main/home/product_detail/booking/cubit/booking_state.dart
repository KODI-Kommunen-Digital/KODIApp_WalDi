import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState.loading() = BookingStateLoading;

  const factory BookingState.loaded(Map<String, int> availableSlots, List<String> services) = BookingStateLoaded;

  const factory BookingState.error(String error) = BookingStateError;
}

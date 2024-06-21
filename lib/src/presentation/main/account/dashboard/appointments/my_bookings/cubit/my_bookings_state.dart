import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_booking.dart';

part 'my_bookings_state.freezed.dart';

@freezed
class MyBookingsState with _$MyBookingsState {
  const factory MyBookingsState.initial() = MyBookingsStateInitial;

  const factory MyBookingsState.loading() = MyBookingsStateLoading;

  const factory MyBookingsState.loaded(List<BookingModel> bookings, bool isRefreshLoader) = MyBookingsStateLoaded;

  const factory MyBookingsState.error(String msg) = MyBookingsStateError;
}

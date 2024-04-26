// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/cubit/booking_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:intl/intl.dart';

class BookingCubit extends Cubit<BookingState> {
  final ListRepository _repo;
  late AppointmentRepository _appointmentRepo;
  dynamic selectedDate;
  dynamic selectedService;

  BookingCubit(this._repo) : super(const BookingState.loading());

  Future<void> onLoadBooking(cityId, listingId) async {
    emit(const BookingState.loading());
    final prefs = await Preferences.openBox();
    _appointmentRepo = AppointmentRepository(prefs);

    if (cityId != null && listingId != null) {
      final appointment =
          await _appointmentRepo.loadAppointment(cityId, listingId);

      if (appointment != null) {
        final services = await _appointmentRepo.loadAppointmentServices(
            cityId!, listingId, appointment.id!);

        if (services != null) {
          if (selectedDate != null && selectedService != null) {
            selectedDate = selectedDate;
            final availableSlots = await _appointmentRepo.loadAppointmentSlots(
                cityId,
                listingId,
                appointment.id!,
                parseDate(selectedDate),
                [selectedService.id.toString()]);

            if (availableSlots != null) {
              emit(BookingState.loaded(availableSlots, services, appointment));
            }
          }
          emit(BookingState.loaded(null, services, appointment));
        } else {
          emit(const BookingState.error("Failed loading services"));
        }
      } else {
        emit(const BookingState.error("Failed loading appointment"));
      }
    } else {
      emit(const BookingState.error("No city or listing id given"));
    }
  }

  String parseDate(String date) {
    DateFormat originalDateFormat = DateFormat('dd.MM.yyyy');
    DateTime dateTime = originalDateFormat.parse(date);

    DateFormat newDateFormat = DateFormat('yyyy-MM-dd');
    return newDateFormat.format(dateTime);
  }
}

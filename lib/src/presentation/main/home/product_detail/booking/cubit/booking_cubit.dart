// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_appointment_slot.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
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
          await AppointmentRepository.loadAppointment(cityId, listingId);

      if (appointment != null) {
        final services = await AppointmentRepository.loadAppointmentServices(
            cityId!, listingId, appointment.id!);

        if (services != null) {
          if (selectedDate != null && selectedService != null) {
            selectedDate = selectedDate;
            AppointmentSlotModel? availableSlots;
            try {
              availableSlots = await _appointmentRepo.loadAppointmentSlots(
                  cityId,
                  listingId,
                  appointment.id!,
                  parseDate(selectedDate),
                  [selectedService.id.toString()]);
            } catch (e) {
              emit(BookingState.loaded(null, services, appointment, true));
              return;
            }

            if (availableSlots != null) {
              emit(BookingState.loaded(
                  availableSlots, services, appointment, false));
              return;
            }
          }
          emit(BookingState.loaded(null, services, appointment, false));
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

  Future<bool> onSubmit(
      {required BookingGuestModel guestDetails,
      required String date,
      String? startTime,
      String? endTime,
      List<BookingGuestModel>? friends,
      required int cityId,
      required int listingId,
      required int serviceId,
      required int appointmentId}) async {
    final response = await _appointmentRepo.saveBooking(
        startTime: startTime,
        endTime: endTime,
        guestDetails: guestDetails,
        date: date,
        cityId: cityId,
        listingId: listingId,
        appointmentId: appointmentId,
        serviceId: serviceId,
        friends: friends);
    return response.success;
  }

  String parseDate(String date) {
    DateFormat originalDateFormat = DateFormat('dd.MM.yyyy');
    DateTime dateTime = originalDateFormat.parse(date);

    DateFormat newDateFormat = DateFormat('yyyy-MM-dd');
    return newDateFormat.format(dateTime);
  }
}

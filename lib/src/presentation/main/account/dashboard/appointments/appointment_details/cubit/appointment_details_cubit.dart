import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:intl/intl.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit() : super(const AppointmentDetailsState.loading());

  late AppointmentRepository repo;

  Future<void> onLoad(bool isRefreshLoader, int appointmentId) async {
    if (!isRefreshLoader) {
      emit(const AppointmentDetailsState.loading());
      final prefs = await Preferences.openBox();
      repo = AppointmentRepository(prefs);
    }

    //Guest Details missing
    List<BookingModel>? bookings =
        await repo.loadOwnerBookings(1, appointmentId);

    if (bookings != null) {
      List<BookingGuestModel> guests = [];

      for (var booking in bookings) {
        UserModel? guest =
            await UserRepository.requestUserDetails(booking.userId);
        if (guest != null) {
          guests.add(BookingGuestModel.fromUser(guest, slot: getSchedule(booking.startTime!, booking.endTime!)));
        }
      }

      if ((bookings.isNotEmpty && guests.isNotEmpty) ||
          (bookings.isEmpty && guests.isEmpty)) {
        emit(AppointmentDetailsState.loaded(bookings, guests, false));
      } else {
        emit(const AppointmentDetailsState.error("Failed to load guests."));
      }
    } else {
      emit(const AppointmentDetailsState.error("Failed to load appointments."));
    }
  }


  ScheduleModel getSchedule(String start, String end) {
    String startDate = start.substring(0, 10);
    String endDate = end.substring(0, 10);
    String date = _formatDate(startDate);

    if (startDate != endDate) {
      date = "$date - ${_formatDate(endDate)}";
    }

    String startTime = start.substring(10);
    String endTime = end.substring(10);

    String formattedTime = "$startTime - $endTime";

    ScheduleModel schedule = ScheduleModel.fromString(formattedTime, date: date);
    return schedule;
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}

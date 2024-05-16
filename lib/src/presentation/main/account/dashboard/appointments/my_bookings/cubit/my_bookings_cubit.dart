import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_bookings/cubit/my_bookings_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  MyBookingsCubit() : super(const MyBookingsState.loading()) {
    onLoad(false);
  }

  late AppointmentRepository repo;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const MyBookingsState.loading());
      final prefs = await Preferences.openBox();
      repo = AppointmentRepository(prefs);
    }

    List<BookingModel>? responseData = await repo.loadUserBookings(1);

    if (responseData != null) {
      List<BookingModel> bookings = [];

      for (var booking in responseData) {
        ProductModel? product =
            await AppointmentRepository.getProductForAppointment(
                booking.appointmentId);
        if (product != null) {
          bookings.add(BookingModel(
              id: booking.id,
              appointmentId: booking.appointmentId,
              createdAt: booking.createdAt,
              startTime: booking.startTime,
              endTime: booking.endTime,
              userId: booking.userId,
              guestId: booking.guestId,
              isGuest: booking.isGuest,
              remark: booking.remark,
              createdBy: booking.createdBy,
              isCreatedByGuest: booking.isCreatedByGuest,
              description: booking.description,
              appointmentTitle: product.title,
          imageLink: product.image));
        } else {
          bookings.add(booking);
          logError("Failed loading product for booking ${booking.id}");
        }
      }
      emit(MyBookingsState.loaded(bookings, false));
    } else {
      emit(const MyBookingsState.error("Failed loading bookings"));
    }
  }

  Future<List<BookingModel>> newBookings(
      int pageNo, List<BookingModel> previous) async {
    List<BookingModel> bookings = previous;
    List<BookingModel>? newResponseBookings =
        await repo.loadUserBookings(pageNo);

    if (newResponseBookings != null) {
      for (var booking in newResponseBookings) {
        ProductModel? product =
            await AppointmentRepository.getProductForAppointment(
                booking.appointmentId);
        if (product != null) {
          bookings.add(BookingModel(
              id: booking.id,
              appointmentId: booking.appointmentId,
              createdAt: booking.createdAt,
              startTime: booking.startTime,
              endTime: booking.endTime,
              userId: booking.userId,
              guestId: booking.guestId,
              isGuest: booking.isGuest,
              remark: booking.remark,
              createdBy: booking.createdBy,
              isCreatedByGuest: booking.isCreatedByGuest,
              description: booking.description,
              appointmentTitle: product.title));
        } else {
          bookings.add(booking);
          logError("Failed loading product for booking ${booking.id}");
        }
      }
    }

    return bookings;
  }

  Future<void> deleteBooking(BookingModel booking) async {
    emit(const MyBookingsState.loading());

    final prefs = await Preferences.openBox();
    int userId = prefs.getKeyValue(Preferences.userId, -1);

    if (userId == -1) {
      emit(const MyBookingsState.error("Failed deleting booking"));
      logError("Failed loading product for booking, can't fetch userId");
    } else {
      bool success = await repo.deleteBookingUser(
          userId, booking.appointmentId, booking.id);

      if (success) {
        onLoad(false);
      } else {
        emit(const MyBookingsState.error("Failed deleting booking"));
        logError("Failed deleting booking");
      }
    }
  }
}

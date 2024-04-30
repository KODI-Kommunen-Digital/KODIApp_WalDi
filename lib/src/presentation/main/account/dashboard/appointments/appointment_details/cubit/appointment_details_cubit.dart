import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
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

    //Guest Details missing, wait for backend
    List<BookingModel>? bookings =
        await repo.loadOwnerBookings(1, appointmentId);
    emit(AppointmentDetailsState.loaded(bookings ?? [], false));
  }
}

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit() : super(const MyAppointmentsState.loading()) {
    onLoad(false);
  }

  late AppointmentRepository repo;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const MyAppointmentsState.loading());
      final prefs = await Preferences.openBox();
      repo = AppointmentRepository(prefs);
    }

    List<AppointmentModel>? appointments = await repo.loadUserAppointments(1);
    emit(MyAppointmentsState.loaded(appointments, false));
  }

  Future<List<AppointmentModel>> newListings(
      int pageNo, List<AppointmentModel> previous) async {
    List<AppointmentModel> appointments = previous;
    List<AppointmentModel>? newAppointments =
        await repo.loadUserAppointments(pageNo);
    if (newAppointments != null && newAppointments.isNotEmpty) {
      appointments.addAll(newAppointments);
    }
    return appointments;
  }

  Future<void> deleteAppointment(
      AppointmentModel appointment, bool deleteListing) async {
    emit(const MyAppointmentsState.loading());
    ProductModel? product = await getProductFromAppointment(appointment.id!);

    if (product != null) {
      bool success = await repo.deleteAppointment(
          product.cityId ?? 0, product.id, appointment.id!, deleteListing);
      if (success) {
        onLoad(false);
      } else {
        logError("Error deleting appointment");
        emit(const MyAppointmentsState.error("Error deleting appointment"));
      }
    } else {
      emit(const MyAppointmentsState.error("Error deleting appointment"));
    }
  }

  Future<bool> onEditAppointment(
      {List<OpenTimeModel?>? openHours,
      List<HolidayModel>? holidays,
      List<AppointmentServiceModel>? services,
      required int cityId,
      required int appointmentId}) async {
    try {
      final prefs = await Preferences.openBox();
      final listindId = prefs.getKeyValue(Preferences.listingId, 1);
      final listingTitle = prefs.getKeyValue(Preferences.listingTitle, '');
      final listingDesc = prefs.getKeyValue(Preferences.listingDesc, '');
      AppointmentRepository repoAppointment = AppointmentRepository(prefs);

      if (services == null) {
        ProductModel? product =
            await AppointmentRepository.getProductForAppointment(appointmentId);
        if (product != null) {
          List<AppointmentServiceModel>? loadedServices =
              await AppointmentRepository.loadAppointmentServices(
                  product.cityId!, product.id, appointmentId);
          if (loadedServices != null) {
            services = loadedServices;
          } else {
            logError("No services, error");
          }
        } else {
          logError("No services, couldn't load product, error");
        }
      }

      List<CategoryModel> cities = AppBloc.homeCubit.location;
      String city = cities.firstWhere((element) => element.id == cityId).title;

      final response = await repoAppointment.editAppointment(
          listingId: listindId,
          appointmentId: appointmentId,
          title: listingTitle,
          description: listingDesc,
          startDate: "2024-04-02T12:30:45.000Z",
          maxBookingPerSlot: 8,
          openHours: openHours,
          holidays: holidays,
          city: city,
          services: services);
      if (response.success) {
        return true;
      } else {
        logError('Edit Appointment Error', response.message);
        return false;
      }
    } catch (e, stackTrace) {
      logError('Edit Appointment Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<ProductModel?> getProductFromAppointment(int appointmentId) async {
    ProductModel? product =
        await AppointmentRepository.getProductForAppointment(appointmentId);
    if (product != null) {
      return product;
    }
    logError("Error fetching product for appointment");
    return null;
  }
}

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
    final prefs = await Preferences.openBox();
    int userId = prefs.getKeyValue('userId', 0);

    List<AppointmentModel>? appointments =
        await repo.loadUserAppointments(userId, 1);
    emit(MyAppointmentsState.loaded(appointments, false));
  }

  Future<List<AppointmentModel>> newAppointments(
      int pageNo, List<AppointmentModel> previous) async {
    final prefs = await Preferences.openBox();
    int userId = prefs.getKeyValue('userId', 0);
    List<AppointmentModel> appointments = previous;
    List<AppointmentModel>? newAppointments =
        await repo.loadUserAppointments(userId, pageNo);
    if (newAppointments != null && newAppointments.isNotEmpty) {
      appointments.addAll(newAppointments);
    }
    return appointments;
  }

  Future<bool> deleteAppointment(AppointmentModel appointment) async {
    ProductModel? product = await getProductFromAppointment(appointment.id!);

    if (product != null) {
      bool success = await repo.deleteAppointment(
          product.cityId ?? 0, product.id, appointment.id!);
      if (success) {
        return true;
      } else {
        logError("Error deleting appointment");
      }
    } else {
      logError("Error fetching product for appointment");
    }
    return false;
  }

  Future<bool> onEditAppointment(
      {List<OpenTimeModel?>? openHours,
      List<HolidayModel>? holidays,
      List<AppointmentServiceModel>? services,
      required int cityId,
      required int appointmentId}) async {
    try {
      final prefs = await Preferences.openBox();
      AppointmentRepository repoAppointment = AppointmentRepository(prefs);

      ProductModel? product =
          await AppointmentRepository.getProductForAppointment(appointmentId);
      if (product != null) {
        if (services == null) {
          List<AppointmentServiceModel>? loadedServices =
              await AppointmentRepository.loadAppointmentServices(
                  product.cityId!, product.id, appointmentId);
          if (loadedServices != null) {
            services = loadedServices;
          } else {
            logError("No services, error");
          }
        }

        List<CategoryModel> cities = AppBloc.homeCubit.location;
        String city =
            cities.firstWhere((element) => element.id == cityId).title;

        final response = await repoAppointment.editAppointment(
            listingId: product.id,
            appointmentId: appointmentId,
            title: product.title,
            description: product.description,
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
      } else {
        logError("Couldn't load product, error");
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

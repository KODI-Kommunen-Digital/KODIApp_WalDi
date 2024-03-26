import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_appointment_slot.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:intl/intl.dart';

class AppointmentRepository {
  final Preferences prefs;

  AppointmentRepository(this.prefs);

  Future<List<AppointmentModel>?> loadUserAppointments(
      int id, int pageNo) async {
    int userId;
    if (id == 0) {
      userId = prefs.getKeyValue('userId', 0);
    } else {
      userId = id;
    }

    final response = await Api.requestUserAppointments(userId, pageNo);
    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return AppointmentModel.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load User Appointments Error', response.message);
    }
    return null;
  }

  Future<List<AppointmentServiceModel>?> loadAppointmentServices(
      int cityId, int listingId, int appointmentId) async {
    final response = await Api.requestAppointmentServices(
        cityId: cityId, listingId: listingId, appointmentId: appointmentId);
    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return AppointmentServiceModel.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Appointment Services Error', response.message);
    }
    return null;
  }

  Future<List<AppointmentSlotModel>?> loadAppointmentSlots(
      int cityId,
      int listingId,
      int appointmentId,
      String date,
      List<String> serviceId) async {
    final DateTime parsedDate = DateTime.parse(date);
    date = DateFormat('yyyy-MM-dd').format(parsedDate);

    final response = await Api.requestAppointmentSlots(
        cityId: cityId,
        listingId: listingId,
        appointmentId: appointmentId,
        date: date,
        serviceId: serviceId);
    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return AppointmentSlotModel.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Appointment Slots Error', response.message);
    }
    return null;
  }

  Future<ResultApiModel> saveAppointment(
      {required int listingId,
      required String title,
      required String description,
      String? startDate,
      String? endDate,
      int? maxBookingPerSlot,
      List<OpenTimeModel>? openHours,
      List<HolidayModel>? holidays,
      List<AppointmentServiceModel>? services}) async {
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);

    final DateTime? parsedStartDate = DateTime.tryParse(startDate ?? '');
    final DateTime? parsedEndDate = DateTime.tryParse(endDate ?? '');

    if (parsedStartDate != null) {
      startDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedStartDate);
    }
    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedEndDate);
    }

    List<Map<String, String>>? parsedHolidays = parseHolidays(holidays);
    Map<String, List<Map<String, String>>>? parsedOpenHours =
        parseOpenHours(openHours);
    List<Map<String, dynamic>>? parsedServicesParams;

    if (services != null) {
      parsedServicesParams = AppointmentServiceModel.parseToParams(services);
    }

    Map<String, dynamic> metaData = {
      'Holidays': parsedHolidays,
      'maxBookingPerSlot': maxBookingPerSlot,
      'OpeningDates': parsedOpenHours
    };

    Map<String, dynamic> params = {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'metadata': metaData,
      'services': parsedServicesParams
    };

    final response =
        await Api.requestSaveAppointment(cityId, listingId, params);

    if (!response.success) {
      logError('Save Appointment Error', response.message);
    }
    return response;
  }

  Future<int> getCityId(cityName) async {
    final response = await Api.requestSubmitCities();
    var jsonCategory = response.data;
    final item = jsonCategory.firstWhere((item) => item['name'] == cityName);
    final itemId = item['id'];
    final cityId = itemId;
    return cityId;
  }

  static List<Map<String, String>>? parseHolidays(
      List<HolidayModel>? holidays) {
    List<Map<String, String>>? parsedHolidays = [];
    if (holidays != null) {
      for (HolidayModel holiday in holidays) {
        final String dateString =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(holiday.date));
        parsedHolidays.add({'date': dateString, 'title': holiday.title});
      }
    } else {
      parsedHolidays = null;
    }
    return parsedHolidays;
  }

  static Map<String, List<Map<String, String>>>? parseOpenHours(
      List<OpenTimeModel>? openHours) {
    Map<String, List<Map<String, String>>>? parsedOpenHours = {};
    if (openHours != null) {
      const daysOfWeek = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      for (OpenTimeModel day in openHours) {
        List<Map<String, String>> hours = [];
        for (ScheduleModel schedule in day.schedule) {
          String startTime =
              AppointmentModel.stringFromTimeOfDay(schedule.start);
          String endTime = AppointmentModel.stringFromTimeOfDay(schedule.end);
          hours.add({'startTime': startTime, 'endTime': endTime});
        }
        parsedOpenHours[daysOfWeek[day.dayOfWeek - 1]] = hours;
      }
    } else {
      parsedOpenHours = null;
    }
    return parsedOpenHours;
  }
}

import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_appointment_slot.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
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
      required String startDate,
      String? endDate,
      int? maxBookingPerSlot,
      List<OpenTimeModel>? openHours,
      List<HolidayModel>? holidays,
      List<AppointmentServiceModel>? services}) async {
    final DateTime parsedStartDate = DateTime.parse(startDate);
    final DateTime? parsedEndDate = DateTime.tryParse(endDate ?? '');

    startDate = DateFormat('yyyy-MM-ddTHH:mm').format(parsedStartDate);
    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-ddTHH:mm').format(parsedEndDate);
    }

    List<Map<String, String>>? parsedHolidays = parseHolidays(holidays);
    Map<String, List<Map<String, String>>?>? parsedOpenHours;
    List<Map<String, dynamic>>? parsedServicesParams;

    if (openHours != null) {
      parsedOpenHours = parseOpenHours(openHours);
    }

    if (services != null) {
      parsedServicesParams = AppointmentServiceModel.parseToParams(services);
    }

    Map<String, dynamic> metaData = {};
    if (parsedHolidays != null) {
      metaData['holidays'] = parsedHolidays;
    } else {
      metaData['holidays'] = [];
    }
    if (maxBookingPerSlot != null) {
      metaData['maxBookingPerSlot'] = maxBookingPerSlot;
    }
    if (parsedOpenHours != null && parsedOpenHours.isNotEmpty) {
      metaData['openingDates'] = parsedOpenHours;
    }

    Map<String, dynamic> params = {
      'title': title,
      'description': description,
      'startDate': startDate,
      'metadata': metaData,
      'services': parsedServicesParams ?? []
    };

    if (endDate != null) {
      params['endDate'] = endDate;
    }

    final response = await Api.requestSaveAppointment(1, listingId, params);
    if (!response.success) {
      logError('Save Appointment Error', response.message);
    }
    return response;
  }

  Future<ResultApiModel> editAppointment(
      {required int listingId,
      required int appointmentId,
      String? title,
      String? description,
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
      startDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedStartDate);
    }
    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedEndDate);
    }

    List<Map<String, String>>? parsedHolidays = parseHolidays(holidays);
    Map<String, List<Map<String, String>>?>? parsedOpenHours;
    List<Map<String, dynamic>>? parsedServicesParams;

    if (openHours != null) {
      parsedOpenHours = parseOpenHours(openHours);
    }

    if (services != null) {
      parsedServicesParams = AppointmentServiceModel.parseToParams(services);
    }

    Map<String, dynamic> metaData = {
      'holidays': parsedHolidays,
      'maxBookingPerSlot': maxBookingPerSlot ?? 8,
      'openingDates': parsedOpenHours
    };

    Map<String, dynamic> params = {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'metadata': metaData,
      'services': parsedServicesParams
    };

    final response = await Api.requestEditAppointment(
        cityId, listingId, appointmentId, params);

    if (!response.success) {
      logError('Edit Appointment Error', response.message);
    }
    return response;
  }

  Future<bool> deleteAppointment(
      int cityId, int listingId, int appointmentId) async {
    final response =
        await Api.requestDeleteAppointment(cityId, listingId, appointmentId);
    if (response.success) {
      return true;
    } else {
      logError('Remove Appointment Failed', response.message);
      return false;
    }
  }

  Future<List<BookingModel>?> loadOwnerBookings(
      int id, int pageNo, int appointmentId,
      {String? startDate}) async {
    int userId;
    if (id == 0) {
      userId = prefs.getKeyValue('userId', 0);
    } else {
      userId = id;
    }
    if (startDate != null) {
      startDate =
          "&${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}";
    }
    final response = await Api.requestOwnerBookings(
        userId, appointmentId, pageNo, startDate);

    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return BookingModel.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Owner Bookings Error', response.message);
    }
    return null;
  }

  Future<List<BookingModel>?> loadUserBookings(int id) async {
    int userId;
    if (id == 0) {
      userId = prefs.getKeyValue('userId', 0);
    } else {
      userId = id;
    }

    final response = await Api.requestUserBookings(userId);

    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return BookingModel.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load User Bookings Error', response.message);
    }
    return null;
  }

  Future<ResultApiModel> saveBooking(
      {required BookingGuestModel guestDetails,
      required String date,
      String? startTime,
      String? endTime,
      List<BookingGuestModel>? friends,
      required int cityId,
      required int listingId,
      required int appointmentId}) async {
    date = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    List<Map<String, String>>? friendDetails = [];

    if (friends != null) {
      for (BookingGuestModel friend in friends) {
        friendDetails.add({
          'fistname': friend.firstname,
          'lastName': friend.lastname,
          'description': friend.description,
          'emailId': friend.emailId
        });
      }
    } else {
      friends = null;
    }

    Map<String, dynamic> params = {
      'guestDetails': {
        'fistname': guestDetails.firstname,
        'lastName': guestDetails.lastname,
        'description': guestDetails.description,
        'emailId': guestDetails.emailId
      },
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'friends': friendDetails
    };

    final response =
        await Api.requestSaveBooking(cityId, listingId, appointmentId, params);

    if (!response.success) {
      logError('Save Booking Error', response.message);
    }
    return response;
  }

  Future<bool> deleteBooking(
      int cityId, int listingId, int appointmentId, int bookingId) async {
    final response = await Api.requestDeleteBooking(
        cityId, listingId, appointmentId, bookingId);

    if (response.success) {
      return true;
    } else {
      logError('Delete Booking error', response.message);
      return false;
    }
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

  static Map<String, List<Map<String, String>>?> parseOpenHours(
      List<OpenTimeModel> openHours) {
    const daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    Map<String, List<Map<String, String>>?> parsedOpenHours = {};
    for (int i = 0; i < 7; i++) {
      OpenTimeModel day =
          openHours.firstWhere((element) => element.dayOfWeek == i + 1);
      List<Map<String, String>> hours = [];
      for (ScheduleModel schedule in day.schedule) {
        String startTime =
            AppointmentModel.stringFromTimeOfDay(schedule.startTime);
        String endTime = AppointmentModel.stringFromTimeOfDay(schedule.endTime);
        hours.add({'startTime': startTime, 'endTime': endTime});
      }
      parsedOpenHours[daysOfWeek[day.dayOfWeek - 1]] = hours;
    }
    return parsedOpenHours;
  }
}

import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

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
}

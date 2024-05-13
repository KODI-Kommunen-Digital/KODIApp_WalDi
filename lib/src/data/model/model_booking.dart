import 'package:intl/intl.dart';

class BookingModel {
  final int id;
  final int appointmentId;
  final String? createdAt;
  final String? startTime;
  final String? endTime;
  final int userId;
  final int guestId;
  final bool isGuest;
  final String? remark;
  final String? description;
  final int? createdBy;
  final bool isCreatedByGuest;
  final String? appointmentTitle;
  final GuestDetails? guestDetails;

  BookingModel({
    required this.id,
    required this.appointmentId,
    this.createdAt,
    this.startTime,
    this.endTime,
    required this.userId,
    required this.guestId,
    required this.isGuest,
    this.remark,
    this.createdBy,
    required this.isCreatedByGuest,
    this.appointmentTitle,
    this.description,
    this.guestDetails,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    String? endDate;
    final DateTime? parsedStartDate =
        DateTime.tryParse(json['startTime'] ?? '');
    if (json['endTime'] != null) {
      final DateTime? parsedEndDate = DateTime.tryParse(json['endTime'] ?? '');
      if (parsedEndDate != null) {
        endDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedEndDate);
      }
    }
    final DateTime? parsedCreatedDate =
        DateTime.tryParse(json['createdAt'] ?? '');

    String? startDate;
    String? createdAt;

    if (parsedStartDate != null) {
      startDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedStartDate);
    }

    if (parsedCreatedDate != null) {
      createdAt = DateFormat('yyyy-MM-ddHH:mm').format(parsedCreatedDate);
    }

    return BookingModel(
        id: json['id'],
        appointmentId: json['appointmentId'],
        startTime: startDate,
        endTime: endDate,
        createdAt: createdAt,
        userId: json['userId'] ?? 1,
        guestId: json['guestId'],
        isGuest: ((json['isGuest'] ?? 0) == 1),
        isCreatedByGuest: ((json['isCreatedByGuest'] ?? 0) == 1),
        createdBy: json['createdBy'],
        remark: json['remark'],
        description: json['description'],
        guestDetails: GuestDetails.fromJson(json['guest_details']));
  }

  String getStartTime() {
    if (startTime == null) return '';

    String startDate = _formatDate(startTime!.substring(0, 10));
    String startHour = startTime!.substring(10);
    return "$startDate, $startHour";
  }

  String dateTimeRange() {
    if (startTime == null || endTime == null) return '';

    String startDate = startTime!.substring(0, 10);
    String startTimeOnly = startTime!.substring(10);
    String endDate = endTime!.substring(0, 10);
    String endTimeOnly = endTime!.substring(10);

    String formattedStartDate = _formatDate(startDate);
    String formattedEndDate = _formatDate(endDate);

    String formattedDateTimeRange =
        '$formattedStartDate, $startTimeOnly - $formattedEndDate, $endTimeOnly';

    return formattedDateTimeRange;
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}

class GuestDetails {
  final String email;
  final String lastname;
  final String firstname;

  GuestDetails({
    required this.email,
    required this.lastname,
    required this.firstname,
  });

  factory GuestDetails.fromJson(Map<String, dynamic> json) {
    return GuestDetails(
      email: json['email'],
      lastname: json['lastName'],
      firstname: json['firstName'],
    );
  }
}

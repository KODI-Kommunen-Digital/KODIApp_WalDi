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

  BookingModel(
      {required this.id,
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
      this.description});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final DateTime? parsedStartDate =
        DateTime.tryParse(json['startTime'] ?? '');
    final DateTime? parsedEndDate = DateTime.tryParse(json['endTime'] ?? '');
    final DateTime? parsedCreatedDate =
        DateTime.tryParse(json['createdAt'] ?? '');

    String? startDate;
    String? endDate;
    String? createdAt;

    if (parsedStartDate != null) {
      startDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedStartDate);
    }
    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedEndDate);
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
        userId: json['userId'],
        guestId: json['guestId'],
        isGuest: ((json['isGuest'] ?? 0) == 1),
        isCreatedByGuest: ((json['isCreatedByGuest'] ?? 0) == 1),
        createdBy: json['createdBy'],
        remark: json['remark'],
        description: json['description']);
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

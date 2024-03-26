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
  final int? createdBy;
  final bool isCreatedByGuest;

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
      required this.isCreatedByGuest});

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
      startDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedStartDate);
    }
    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedEndDate);
    }
    if (parsedCreatedDate != null) {
      createdAt = DateFormat('yyyy-MM-dd HH:mm').format(parsedCreatedDate);
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
        remark: json['remark']);
  }
}

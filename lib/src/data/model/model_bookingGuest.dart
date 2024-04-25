// ignore_for_file: file_names

class BookingGuestModel {
  final String firstname;
  final String lastname;
  final String description;
  final String emailId;
  final String? phoneNumber;

  BookingGuestModel(
      {required this.firstname,
      required this.lastname,
      required this.description,
      required this.emailId,
      this.phoneNumber});
}

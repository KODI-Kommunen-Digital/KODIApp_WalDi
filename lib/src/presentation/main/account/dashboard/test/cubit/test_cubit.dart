// import 'package:bloc/bloc.dart';
// import 'package:heidi/src/data/model/model_booking.dart';
// import 'package:heidi/src/data/model/model_bookingGuest.dart';
// import 'package:heidi/src/data/model/model_product.dart';
// import 'package:heidi/src/data/model/model_result_api.dart';
// import 'package:heidi/src/data/remote/api/api.dart';
// import 'package:heidi/src/data/repository/appointment_repository.dart';
// import 'package:heidi/src/presentation/main/account/dashboard/test/cubit/test_state.dart';
// import 'package:heidi/src/utils/configs/preferences.dart';

// class TestCubit extends Cubit<TestState> {
//   TestCubit() : super(const TestStateLoading());

//   Future<void> onLoad() async {
//     emit(const TestStateLoading());
//     final ResultApiModel listingsRequestResponse =
//         await Api.requestTestListings();

//     List<ProductModel> productData =
//         List.from(listingsRequestResponse.data ?? []).map((item) {
//       return ProductModel.fromJson(item);
//     }).toList();

//     emit(TestStateLoaded(productData));
//   }

//   Future<void> fetchAppointments() async {
//     emit(const TestStateLoading());
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     final List<BookingModel>? appointments = await repo.loadUserBookings(1);
//     emit(TestStateLoaded(appointments));
//   }

//   Future<void> postAppointment(int id) async {
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     ResultApiModel response = await repo.saveAppointment(
//         listingId: id,
//         title: "title",
//         description: "description",
//         startDate: "2024-02-23T14:00:00");
//   }

//   Future<void> editAppointment(int listingId, int appointmentId) async {
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     ResultApiModel response = await repo.editAppointment(
//         listingId: listingId, appointmentId: appointmentId);
//   }

//   Future<void> deleteAppointment(
//       int cityId, int listingId, int appointmentId) async {
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     bool response =
//         await repo.deleteAppointment(cityId, listingId, appointmentId);
//   }

//   Future<void> fetchOwnerBookings() async {
//     emit(const TestStateLoading());
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     //      int id, int pageNo, int appointmentId,
//     //       {String? startDate}
//     final List<BookingModel>? bookings = await repo.loadOwnerBookings(1, 1, 1);
//     print(bookings);
//   }

//   Future<void> fetchUserBookings() async {
//     emit(const TestStateLoading());
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     final List<BookingModel>? bookings = await repo.loadUserBookings(1);
//     print(bookings);
//   }

//   Future<void> postBooking() async {
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     await repo.saveBooking(
//         guestDetails: BookingGuestModel(
//             firstname: "firstname",
//             lastname: "lastname",
//             description: "description",
//             emailId: "emailId"),
//         date: "2024-02-23T14:00:00",
//         cityId: 1,
//         listingId: 1,
//         appointmentId: 1);
//   }

//   Future<void> deleteBooking() async {
//     final prefs = await Preferences.openBox();
//     AppointmentRepository repo = AppointmentRepository(prefs);
//     bool hasDeleted = await repo.deleteBooking(1, 1, 1, 1);
//     print(hasDeleted);
//   }
// }

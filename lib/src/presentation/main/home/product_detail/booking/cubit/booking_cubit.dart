// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final ListRepository _repo;

  final Map<String, int> _availableSlots = {
    '8:00 - 8:15': 3,
    '8:15 - 8:30': 3,
    '8:30 - 8:45': 3,
    '8:45 - 9:00': 3,
  };

  final List<String> _services = [
    'Haarschnitt',
    'Maniküre',
    'Pediküre',
    'Massage',
  ];

  BookingCubit(this._repo) : super(const BookingState.loading()) {
    onLoadBooking();
  }

  Future<void> onLoadBooking() async {
    emit(BookingState.loaded(_availableSlots, _services));
  }
}

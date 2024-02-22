// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/requests/cubit/appointment_requests_state.dart';

class AppointmentRequestsCubit extends Cubit<AppointmentRequestsState> {
  final ListRepository _repo;

  AppointmentRequestsCubit(this._repo)
      : super(const AppointmentRequestsState.loading()) {
    onLoad(false);
  }

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const AppointmentRequestsState.loading());
    List<String> sampleData = [
      "aasdas",
      "basdasd",
      "asihjdioa",
      "ahsdf9a",
      "asoihd",
      "asoidh"
    ];
    await Future.delayed(const Duration(seconds: 2));
    emit(AppointmentRequestsState.loaded(sampleData, false));
  }
}

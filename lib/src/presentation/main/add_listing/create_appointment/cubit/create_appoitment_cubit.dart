// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appointment_state.dart';

class CreateAppointmentCubit extends Cubit<CreateAppointmentState> {
  final ListRepository _repo;

  CreateAppointmentCubit(this._repo)
      : super(const CreateAppointmentState.loaded());
}

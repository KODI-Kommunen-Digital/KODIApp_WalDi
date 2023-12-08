import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/utils/translate.dart';

class MyAppointmentsScreen extends StatelessWidget {
  final UserModel user;

  const MyAppointmentsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const MyAppointmentsLoading(),
            loaded: (appointments, isRefreshLoader) => MyAppointmentsLoaded(
                  isRefreshLoader: isRefreshLoader,
                  appointments: appointments,
                  user: user,
                ),
            orElse: () => ErrorWidget("Failed to load appointments.")));
  }
}

class MyAppointmentsLoading extends StatelessWidget {
  const MyAppointmentsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('my_appointments'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}

class MyAppointmentsLoaded extends StatefulWidget {
  final List? appointments;
  final UserModel user;
  final bool isRefreshLoader;

  const MyAppointmentsLoaded(
      {required this.isRefreshLoader,
      required this.user,
      this.appointments,
      super.key});

  @override
  State<MyAppointmentsLoaded> createState() => _MyAppointmentsLoadedState();
}

class _MyAppointmentsLoadedState extends State<MyAppointmentsLoaded> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('my_appointments'),
        ),
      ),
    ));
  }
}

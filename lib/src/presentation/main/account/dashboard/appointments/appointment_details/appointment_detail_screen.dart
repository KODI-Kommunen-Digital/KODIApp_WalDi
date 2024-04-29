// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/appointment_details/cubit/appointment_details_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/appointment_details/cubit/appointment_details_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final AppointmentModel appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AppointmentDetailsCubit>()
        .onLoad(false, widget.appointment.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
      builder: (context, state) => state.maybeWhen(
        loading: () => const AppointmentDetailsLoading(),
        loaded: (bookings, isRefreshLoader) => AppointmentDetailsLoaded(
          bookings: bookings,
          isRefreshLoader: isRefreshLoader,
          appointment: widget.appointment,
        ),
        error: (msg) => ErrorWidget(msg),
        orElse: () => ErrorWidget(
          "Failed to load appointments.",
        ),
      ),
    );
  }
}

class AppointmentDetailsLoading extends StatelessWidget {
  const AppointmentDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //TODO translate
          title: Text("Termindetails"),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}

class AppointmentDetailsLoaded extends StatefulWidget {
  final AppointmentModel appointment;
  final List<BookingModel> bookings;
  final bool isRefreshLoader;

  const AppointmentDetailsLoaded(
      {required this.isRefreshLoader,
      required this.appointment,
      required this.bookings,
      super.key});

  @override
  State<AppointmentDetailsLoaded> createState() => _MyAppointmentsLoadedState();
}

class _MyAppointmentsLoadedState extends State<AppointmentDetailsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  final List<String> _selectedTimeSlots = [
    '8:00 - 8:15',
  ];
  BookingGuestModel guest = BookingGuestModel(
      firstname: "firstname",
      lastname: "lastname",
      description: "description",
      emailId: "emailId");

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            pinned: true,
            // actions: action,
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              background: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.imageZoom,
                    arguments:
                        "https://newheidi.obs.eu-de.otc.t-systems.com/user_8/city_1_listing_15_2_1709543526085",
                  );
                },
                child: Image.network(
                  "https://newheidi.obs.eu-de.otc.t-systems.com/user_8/city_1_listing_15_2_1709543526085",
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle errors here
                    return AppPlaceholder(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 140,
                        child: const Icon(Icons.error),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return AppPlaceholder(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 140,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16),
                  Text(
                    widget.appointment.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  for (int i = 0; i < widget.bookings.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\nKunde ${i + 1}:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                              text: "${guest.firstname}} ${guest.lastname}"),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: Translate.of(context).translate('email'),
                            border: const OutlineInputBorder(),
                          ),
                          controller:
                              TextEditingController(text: guest.emailId),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                        if ((guest.phoneNumber ?? '') != '')
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  labelText:
                                      Translate.of(context).translate('phone'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: guest.phoneNumber),
                                enabled: false, // Make text unchangeable
                                style: const TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ],
                          ),
                        if (guest.description != '')
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: Translate.of(context)
                                      .translate('appointmentNote'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: guest.description),
                                enabled: false, // Make text unchangeable
                                style: const TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('appointmentSchedule'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText:
                          Translate.of(context).translate('appointmentDate'),
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                        text: widget.appointment.startDate),
                    enabled: false, // Make text unchangeable
                    style: const TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  for (final slots in _selectedTimeSlots)
                    Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: Translate.of(context)
                                .translate('appointmentSlot'),
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: slots),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

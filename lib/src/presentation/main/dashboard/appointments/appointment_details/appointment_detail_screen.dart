import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/appointment_details/cubit/appointment_details_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/appointment_details/cubit/appointment_details_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
      builder: (context, state) => state.maybeWhen(
        loading: () => const AppointmentDetailsLoading(),
        loaded: (appointments, isRefreshLoader) => AppointmentDetailsLoaded(
          isRefreshLoader: isRefreshLoader,
          appointments: appointments,
        ),
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
          title: Text(
            Translate.of(context).translate('my_appointments'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}

class AppointmentDetailsLoaded extends StatefulWidget {
  final List<String> appointments;
  final bool isRefreshLoader;

  const AppointmentDetailsLoaded(
      {required this.isRefreshLoader, required this.appointments, super.key});

  @override
  State<AppointmentDetailsLoaded> createState() => _MyAppointmentsLoadedState();
}

class _MyAppointmentsLoadedState extends State<AppointmentDetailsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  List<String> appointments = [];
  final List<String> _selectedTimeSlots = [
    '8:00 - 8:15',
    '8:15 - 8:30',
    '8:30 - 8:45',
    '8:45 - 9:00',
  ];

  @override
  void initState() {
    super.initState();
    appointments.addAll(widget.appointments);
  }

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
                    arguments: "https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png",
                  );
                },
                child: Image.network(
                  "https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png",
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
                    'Haircut',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  for (int i = 0; i < 2; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\nClient ${i + 1}:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: 'Saud Bin Afaq'),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                              text: 'Saud.afaq123@gmail.com'),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: 'Peter Hille Weg 13'),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: '015785104060'),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Appointment Note',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                              text: 'I want to book another appointment'),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    '\nAppointment Schedule:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Appointment Date',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: '12.01.2024'),
                    enabled: false, // Make text unchangeable
                    style: const TextStyle(color: Colors.white), // Set text color to white
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  for (final slots in _selectedTimeSlots)
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Appointment Slot',
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(text: slots),
                          enabled: false, // Make text unchangeable
                          style: const TextStyle(color: Colors.white), // Set text color to white
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

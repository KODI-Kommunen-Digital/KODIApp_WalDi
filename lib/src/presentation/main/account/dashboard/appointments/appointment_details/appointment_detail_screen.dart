// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/appointment_details/cubit/appointment_details_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/appointment_details/cubit/appointment_details_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
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
        loaded: (bookings, guests, isRefreshLoader, listing) =>
            AppointmentDetailsLoaded(
          isRefreshLoader: isRefreshLoader,
          appointment: widget.appointment,
          guests: guests,
          bookings: bookings,
          listing: listing,
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
  final List<BookingGuestModel> guests;
  final bool isRefreshLoader;
  final List<BookingModel> bookings;
  final ProductModel? listing;

  const AppointmentDetailsLoaded(
      {required this.isRefreshLoader,
      required this.appointment,
      required this.guests,
      required this.bookings,
      required this.listing,
      super.key});

  @override
  State<AppointmentDetailsLoaded> createState() => _MyAppointmentsLoadedState();
}

class _MyAppointmentsLoadedState extends State<AppointmentDetailsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  List<BookingGuestModel> guests = [];
  List<BookingModel> bookings = [];
  bool isLoadingMore = false;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    guests.addAll(widget.guests);
    bookings.addAll(widget.bookings);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        guests = await context
            .read<AppointmentDetailsCubit>()
            .newGuestBookings(++pageNo, guests, widget.appointment.id!);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
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
                    arguments: {
                      'sourceId': widget.listing?.sourceId,
                      'imageList': [ImageListModel(listingId: widget.listing?.id, logo: "${widget.listing?.image}", )],
                      'pdf': null,}
                  );
                },
                child: Image.network(
                  (widget.listing?.image != null)
                      ? "${Application.picturesURL}${widget.listing!.image}"
                      : "https://newheidi.obs.eu-de.otc.t-systems.com/user_8/city_1_listing_15_2_1709543526085",
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
                  for (int i = 0; i < guests.length + 1; i++)
                    (i < guests.length)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\n${Translate.of(context).translate('booking')} ${i + 1}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text:
                                        "${guests[i].firstname} ${guests[i].lastname}"),
                                enabled: false, // Make text unchangeable
                                style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Colors.white),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  labelText:
                                      Translate.of(context).translate('email'),
                                  border: const OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: guests[i].email),
                                enabled: false, // Make text unchangeable
                                style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Colors.white),
                              ),
                              if ((guests[i].phoneNumber ?? '') != '')
                                Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: Translate.of(context)
                                            .translate('phone'),
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: TextEditingController(
                                          text: guests[i].phoneNumber),
                                      enabled: false, // Make text unchangeable
                                      style: TextStyle(
                                          color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color ??
                                              Colors.white),
                                    ),
                                  ],
                                ),
                              if (guests[i].remark != '')
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
                                          text: guests[i].remark),
                                      enabled: false, // Make text unchangeable
                                      style: TextStyle(
                                          color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color ??
                                              Colors.white),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: Translate.of(context)
                                      .translate('appointmentDate'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: guests[i].slot!.date!),
                                enabled: false, // Make text unchangeable
                                style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Colors.white),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: Translate.of(context)
                                      .translate('appointmentSlot'),
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text:
                                        "${guests[i].slot!.startTime.format(context)} - ${guests[i].slot!.endTime.format(context)}"),
                                enabled: false, // Make text unchangeable
                                style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final response = await showRemoveAppointmentPopup(context);
                                  if(response) {
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<AppointmentDetailsCubit>()
                                        .onCancelOwner(
                                            bookings[i].appointmentId,
                                            bookings[i].id);
                                  }

                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Cancel Booking",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : (isLoadingMore)
                            ? const Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              )
                            : Container(),
                  const SizedBox(height: 16),
                  if (guests.isEmpty)
                    Center(
                        child: Text(
                            Translate.of(context).translate("no_bookings"))),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<bool> showRemoveAppointmentPopup(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('delete_appointments'),
          ),
          content: Text(
            Translate.of(context).translate('delete_appointment_confirmation'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Text(
                Translate.of(context).translate('no'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                Translate.of(context).translate('yes'),
              ),
            ),
          ],
        );
      },
    );

    if (result) {
      return true;
    } else {
      return false;
    }
  }
}

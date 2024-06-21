// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_bookings/cubit/my_bookings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/appointments/my_bookings/cubit/my_bookings_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const MyBookingsLoading(),
            loaded: (bookings, isRefreshLoader) => MyBookingsLoaded(
                  isRefreshLoader: isRefreshLoader,
                  bookings: bookings,
                ),
            orElse: () => ErrorWidget("Failed to load appointments.")));
  }
}

class MyBookingsLoading extends StatelessWidget {
  const MyBookingsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('my_bookings'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}

class MyBookingsLoaded extends StatefulWidget {
  final List<BookingModel> bookings;
  final bool isRefreshLoader;

  const MyBookingsLoaded(
      {required this.isRefreshLoader, required this.bookings, super.key});

  @override
  State<MyBookingsLoaded> createState() => _MyBookingsLoadedState();
}

class _MyBookingsLoadedState extends State<MyBookingsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  List<BookingModel> bookings = [];
  bool isLoadingMore = false;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
        bookings = await context
            .read<MyBookingsCubit>()
            .newBookings(++pageNo, bookings);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('my_bookings'),
        ),
      ),
      body: Stack(children: [
        (bookings.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 0),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: _scrollController,
                  slivers: <Widget>[
                    CupertinoSliverRefreshControl(
                      onRefresh: _onRefresh,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index < bookings.length) {
                            final item = bookings[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            ((item.imageLink ?? '').isNotEmpty)
                                                ? "${Application.picturesURL}${item.imageLink!}"
                                                : Application
                                                    .defaultAppointmentPicturesURL,
                                            width: 120,
                                            height: 140,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Handle errors here
                                              return AppPlaceholder(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                  ),
                                                  width: 120,
                                                  height: 140,
                                                  child:
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return AppPlaceholder(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                  ),
                                                  width: 120,
                                                  height: 140,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                item.appointmentTitle ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              if ((item.remark ?? '') != '')
                                                Text(
                                                    '${Translate.of(context).translate('remark')}: ${item.remark}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(item.getStartTime(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${item.appointmentId}-${item.serviceId}-${item.id}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        PopupMenuButton<String>(
                                          icon: const Icon(
                                            Icons
                                                .more_vert, // Three vertical dots icon
                                          ),
                                          onSelected: (String choice) async {
                                            if (choice ==
                                                Translate.of(context).translate(
                                                    'delete_appointments')) {
                                              final response =
                                                  await showRemoveAppointmentPopup(
                                                      context);
                                              if (response) {
                                                bool success = await context
                                                    .read<MyBookingsCubit>()
                                                    .deleteBooking(item);
                                                if (success) {
                                                  setState(() {
                                                    bookings.remove(item);
                                                  });
                                                }
                                              }
                                            }

                                            if (!mounted) return;
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return {
                                              Translate.of(context).translate(
                                                  'delete_appointments'),
                                            }.map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(choice),
                                              );
                                            }).toList();
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return (isLoadingMore)
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Container();
                          }
                        },
                        childCount: bookings.length + 1,
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.sentiment_satisfied),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        Translate.of(context).translate('list_is_empty'),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
      ]),
    ));
  }

  Future<void> _onRefresh() async {
    context.read<MyBookingsCubit>().onLoad(true);
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

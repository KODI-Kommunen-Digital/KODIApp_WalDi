import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsCubit, MyAppointmentsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const MyAppointmentsLoading(),
            loaded: (appointments, isRefreshLoader) => MyAppointmentsLoaded(
                  isRefreshLoader: isRefreshLoader,
                  appointments: appointments,
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
  final List<String> appointments;
  final bool isRefreshLoader;

  const MyAppointmentsLoaded(
      {required this.isRefreshLoader, required this.appointments, super.key});

  @override
  State<MyAppointmentsLoaded> createState() => _MyAppointmentsLoadedState();
}

class _MyAppointmentsLoadedState extends State<MyAppointmentsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  List<String> appointments = [];

  @override
  void initState() {
    super.initState();
    appointments.addAll(widget.appointments);
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('my_appointments'),
        ),
      ),
      body: Stack(children: [
        (appointments.isNotEmpty)
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
                          final item = appointments[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.appointmentDetails);
                              },
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
                                            "https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png",
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
                                                item,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              Text("Haircut",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                              Text("12.01.2024",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!)
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
                                                setState(() {
                                                  appointments.removeAt(index);
                                                });
                                              }
                                            }

                                            if (!mounted) return;

                                            if (choice ==
                                                Translate.of(context).translate(
                                                    'edit_appointments')) {
                                              if (!mounted) return;
                                              Navigator.pushNamed(
                                                context,
                                                Routes.booking,
                                                arguments: appointments[index],
                                              );
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return {
                                              Translate.of(context).translate(
                                                  'delete_appointments'),
                                              Translate.of(context).translate(
                                                  'edit_appointments')
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
                            ),
                          );
                        },
                        childCount: appointments.length,
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
    context.read<MyAppointmentsCubit>().onLoad(true);
  }

  Future<bool> showRemoveAppointmentPopup(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('delete_appointment'),
          ),
          content: Text(
            Translate.of(context).translate('deleteAppointmentConfirmation'),
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

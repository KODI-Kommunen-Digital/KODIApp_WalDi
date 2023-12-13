import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/appointments/my_appointments/cubit/my_appointments_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
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
  final List<String>? appointments;
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
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  List<String>? appointments = [];

  @override
  void initState() {
    super.initState();
    appointments = widget.appointments;
  }

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
      body: Stack(children: [
        (appointments?.isNotEmpty ?? false)
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
                          final item = appointments![index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: InkWell(
                              onTap: () {
                                //Go to appointment
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        //Check whether item is pdf
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            "https://heimat-digital.com/wp-content/uploads/2023/02/1674120769077.jpeg",
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
                                              // Display the AppPlaceholder while the image is loading
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

                                        /*: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(11),
                                                  child: SizedBox(
                                                      width: 120,
                                                      height: 140,
                                                      child: const PDF()
                                                          .cachedFromUrl(
                                                        "${Application.picturesURL}${item.pdf}?cacheKey=$uniqueKey",
                                                        placeholder: (progress) =>
                                                            Center(
                                                                child: Text(
                                                                    '$progress %')),
                                                        errorWidget: (error) =>
                                                            Center(
                                                                child: Text(error
                                                                    .toString())),
                                                      )),
                                                ),*/
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
                                              Text("category",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                              Text("date",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!)
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              //Manage Appointment
                                            },
                                            icon: const Icon(Icons.more_vert))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: appointments!.length,
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
}

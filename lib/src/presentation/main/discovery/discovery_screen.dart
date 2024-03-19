// ignore_for_file: use_build_context_synchronously, unused_element
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/widget/app_filter_button.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/cubit.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int? selectedLocationId;

  @override
  void initState() {
    super.initState();
    loadLocationList();
  }

  Future<void> loadLocationList() async {
    await context.read<DiscoveryCubit>().onLoad();
  }

  Future<void> loadSelectedLocation() async {
    final cityId = await context.read<DiscoveryCubit>().getCitySelected();
    selectedLocationId = cityId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(Translate.of(context).translate('cust_services')),
        actions: [
          BlocConsumer<DiscoveryCubit, DiscoveryState>(
            listener: (context, state) {},
            builder: (context, state) => state.maybeWhen(
                loaded: (list) => AppFilterButton(
                      multiFilter: MultiFilter(
                        hasLocationFilter: true,
                        currentLocation:
                            context.read<DiscoveryCubit>().currentCity ?? 0,
                        cities: context.read<DiscoveryCubit>().location,
                      ),
                      filterCallBack: (filter) async {
                        if (filter.currentLocation != null) {
                          context
                              .read<DiscoveryCubit>()
                              .onLocationFilter(filter.currentLocation!, true);
                        }
                      },
                    ),
                orElse: () => Container()),
          )
        ],
      ),
      body: BlocConsumer<DiscoveryCubit, DiscoveryState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (msg) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg))),
            orElse: () {},
          );
        },
        builder: (context, state) => state.when(
          loading: () {
            return const DiscoveryLoading();
          },
          loaded: (list) => DiscoveryLoaded(
            services: list,
          ),
          updated: (list) => Container(),
          error: (e) => ErrorWidget('Failed to load listings.'),
          initial: () {
            return Container();
          },
        ),
      ),
    );
  }
}

class DiscoveryLoading extends StatelessWidget {
  const DiscoveryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class DiscoveryLoaded extends StatefulWidget {
  final List<CitizenServiceModel> services;

  const DiscoveryLoaded({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  State<DiscoveryLoaded> createState() => _DiscoveryLoadedState();
}

class _DiscoveryLoadedState extends State<DiscoveryLoaded> {
  bool isLoading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // hideEmptyService();
  }

  void scrollUp() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  @override
  Widget build(BuildContext context) {
    if (AppBloc.discoveryCubit.getDoesScroll()) {
      AppBloc.discoveryCubit.setDoesScroll(false);
      scrollUp();
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 300.0,
      ),
      itemCount: widget.services.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            navigateToLink(widget.services[index]);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              widget.services[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _onPopUpError() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(Translate.of(context).translate('functionNotAvail')),
        content: Text(Translate.of(context).translate('functionNotAvailBody')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> navigateToLink(CitizenServiceModel service) async {
    final prefs = await Preferences.openBox();
    if (service.imageLink == "1") {
      String link = await AppBloc.discoveryCubit.getMitredenLink() ?? "";
      Navigator.of(context).pushNamed(Routes.mitredenWebview, arguments: link);
    } else if (service.imageLink == "2") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getCityLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "11") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getToruismLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "12") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getVirtualTourLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else {
      prefs.setKeyValue(Preferences.type, service.type);
      if (service.categoryId != null) {
        prefs.setKeyValue(Preferences.categoryId, service.categoryId);
      }
      Navigator.pushNamed(context, Routes.listProduct,
          arguments: {'id': service.arguments, 'title': ''});
    }
  }
}

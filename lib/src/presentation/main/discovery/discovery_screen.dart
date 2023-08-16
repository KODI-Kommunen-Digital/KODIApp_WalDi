// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/presentation/main/home/home_screen/cubit/home_cubit.dart';
import 'package:heidi/src/presentation/main/home/home_screen/cubit/home_state.dart';
import 'package:heidi/src/utils/configs/image.dart';
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
  ProductFilter? selectedFilter;

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
    setState(() {
      selectedLocationId = cityId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('cust_services')),
        actions: [
          TextButton(
            onPressed: () async {
              await _openFilterDrawer(context);
            },
            style: TextButton.styleFrom(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            child: const Text("Filter"),
          ),
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
            list: list,
          ),
          updated: (list) {
            return DiscoveryLoaded(
              list: list,
            );
          },
          error: (e) => ErrorWidget('Failed to load listings.'),
          initial: () {
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> _openFilterDrawer(BuildContext context) async {
    await loadSelectedLocation();
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[900],
          height: 200,
          child: ListView.separated(
            itemCount: context.read<DiscoveryCubit>().location.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.white,
              height: 1,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final location = context.read<DiscoveryCubit>().location[index];
              final isSelected = selectedLocationId == location.id;
              return ListTile(
                title: Text(location.title),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedLocationId = 0;
                    } else {
                      selectedLocationId = location.id;
                    }
                  });
                  context
                      .read<DiscoveryCubit>()
                      .onLocationFilter(selectedLocationId!);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
//  void _updateSelectedFilter(ProductFilter? filter) {
//    setState(() {
//      selectedFilter = filter;
//    });
//  }
}

class DiscoveryLoading extends StatelessWidget {
  const DiscoveryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class DiscoveryLoaded extends StatefulWidget {
  final List<CategoryModel> list;

  const DiscoveryLoaded({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<DiscoveryLoaded> createState() => _DiscoveryLoadedState();
}

class _DiscoveryLoadedState extends State<DiscoveryLoaded> {
  // final _swipeController = SwiperController();
  // final _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    hideEmptyService();
    //TODOasd
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 300.0,
      ),
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            navigateToLink(services[index]);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              services[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  final List<CitizenServiceModel> hiddenServices = [];

  late List<CitizenServiceModel> services;

  Future<void> hideEmptyService() async {
    services = AppBloc.discoveryCubit.initializeServices();

    for (var element in services) {
      if (element.categoryId != null || element.type == "subCategoryService") {
        bool hasContent = await element.hasContent();
        if (!hasContent) {
          hiddenServices.add(element);
        }
      }
    }

    setState(() {
      services.removeWhere((element) => hiddenServices.contains(element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('cust_services')),
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          hideEmptyService();
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as desired
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 300.0),
          itemCount: services.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                navigateToLink(services[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  services[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
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
    if (service.imageLink == "1") {
      await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "2") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getCityLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "10") {
      _onPopUpError();
    } else {
      AppBloc.discoveryCubit
          .setServiceValue(Preferences.type, service.type, null);
      if (service.categoryId != null) {
        AppBloc.discoveryCubit
            .setServiceValue(Preferences.categoryId, null, service.categoryId);
      }
      Navigator.pushNamed(context, Routes.listProduct,
          arguments: {'id': service.arguments, 'title': ''});
    }
  }
}

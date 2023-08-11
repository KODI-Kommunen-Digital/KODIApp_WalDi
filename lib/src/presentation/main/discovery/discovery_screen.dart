// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/list_product/cubit/list_cubit.dart';
import 'cubit/cubit.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  ProductFilter? selectedFilter;

  @override
  void initState() {
    super.initState();
    loadLocationList();
  }

  Future<void> loadLocationList() async {
    await context.read<DiscoveryCubit>().onLoad();
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
          loading: () => const DiscoveryLoading(),
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
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[900],
          height: 200, // Set the desired height for the drawer
          child: ListView.builder(
            itemCount: context.read<DiscoveryCubit>().location.length,
            itemBuilder: (context, index) {
              final locationName =
                  context.read<DiscoveryCubit>().location[index];
              return ListTile(
                title: Text(locationName),
                onTap: () {
                  // context.read<DiscoveryCubit>().onLocationFilter(locationName,loadedList);
                  context.read<DiscoveryCubit>().onLocationFilter(locationName);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _updateSelectedFilter(ProductFilter? filter) {
    setState(() {
      selectedFilter = filter;
    });
  }
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
      itemCount: widget.list.length,
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

  final List<CitizenServiceModel> services = [
    CitizenServiceModel(imageUrl: Images.service2, imageLink: "2"),
    CitizenServiceModel(
        imageUrl: Images.service3,
        imageLink: "3",
        type: "subCategoryService",
        arguments: 4),
    CitizenServiceModel(
        imageUrl: Images.service4, imageLink: "4", arguments: 4, categoryId: 1),
    CitizenServiceModel(
        imageUrl: Images.service5, imageLink: "5", arguments: 5, categoryId: 3),
    CitizenServiceModel(
        imageUrl: Images.service6, imageLink: "6", arguments: 6, categoryId: 4),
    CitizenServiceModel(
        imageUrl: Images.service7,
        imageLink: "7",
        arguments: 7,
        categoryId: 10),
    CitizenServiceModel(
        imageUrl: Images.service8,
        imageLink: "8",
        arguments: 8,
        categoryId: 13),
    CitizenServiceModel(
        imageUrl: Images.service9, imageLink: "9", arguments: 9, categoryId: 6),
    CitizenServiceModel(imageUrl: Images.service10, imageLink: "error"),
  ];

  Future<void> hideEmptyService() async {
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

  Future<void> loadServicesList() async {
    await hideEmptyService();
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
      await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "2") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getCityLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (service.imageLink == "error") {
      _onPopUpError();
    } else {
      prefs.setKeyValue(Preferences.type, service.type);
      if (service.categoryId != null) {
        prefs.setKeyValue(Preferences.categoryId, service.categoryId);
      }
      Navigator.pushNamed(context, Routes.listProduct,
          arguments: service.arguments);
    }
  }
}

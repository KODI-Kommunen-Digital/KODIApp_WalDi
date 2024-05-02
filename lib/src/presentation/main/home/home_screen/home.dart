// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/discovery/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/widget/home_category_item.dart';
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_category_item.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:upgrader/upgrader.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCityTitle = '';
  int selectedCityId = 0;
  int pageNo = 1;
  late bool checkSavedCity;
  final _scrollController = ScrollController();
  bool isLoading = false;
  bool categoryLoading = false;
  bool isRefreshLoader = false;
  String? banner;
  List<CategoryModel>? category = [];
  List<CategoryModel>? location = [];
  List<ProductModel>? recent = [];
  String latestAppStoreVersion = '';
  String ignoreAppStoreVersion = '';
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    checkSavedCity = true;
    AppBloc.homeCubit.onLoad(false);
    connectivityInternet();
    checkUserExist();
    getIgnoreAppVersion();
  }

  Future<void> getIgnoreAppVersion() async {
    String ignoreVersion = await AppBloc.homeCubit.getIgnoreAppVersion();
    setState(() {
      ignoreAppStoreVersion = ignoreVersion;
    });
  }

  void connectivityInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      AppBloc.homeCubit.onLoad(false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  Future<void> checkUserExist() async {
    bool exists = await AppBloc.homeCubit.doesUserExist();
    if (!exists) {
      AppBloc.loginCubit.onLogout();
    }
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoading = true;
        });
        recent = await AppBloc.homeCubit.newListings(++pageNo).then((_) {
          setState(() {
            isLoading = false;
          });
        }).catchError(
          (error, stackTrace) async {
            setState(() {
              isLoading = false;
            });
            logError('Error loading new listings: $error');
            await Sentry.captureException(error, stackTrace: stackTrace);
          },
        );
      }
    }
  }

  Future<void> _onUpdateCategory() async {
    await AppBloc.homeCubit.onLoad(false);
  }

  void scrollUp() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  Future<void> _onRefresh() async {
    await AppBloc.homeCubit.onLoad(true);
    setState(() {
      pageNo = 1;
    });
  }

  Future<void> _setSavedCity(List<CategoryModel> location) async {
    final savedCity = await AppBloc.homeCubit.checkSavedCity(location);
    if (savedCity != null) {
      setState(() {
        selectedCityId = savedCity.id;
        selectedCityTitle = savedCity.title;
      });
    } else {
      await AppBloc.homeCubit.saveCityId(0);
      setState(() {
        selectedCityId = 0;
      });
    }
    //AppBloc.homeCubit.onLoad(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(Translate.of(context).translate('no_internet')))),
            orElse: () {},
          );
        },
        builder: (context, state) {
          List<String> cityTitles = [
            Translate.of(context).translate('select_location')
          ];

          if (state is HomeStateLoaded) {
            banner = state.banner;
            category = state.category;
            location = state.location;
            recent = state.recent;
            isRefreshLoader = true;
            categoryLoading = false;

            if (location != null) {
              for (final ids in location!) {
                cityTitles.add(ids.title.toString());
              }
              if (checkSavedCity) {
                checkSavedCity = false;
                _setSavedCity(location!);
              } else if (AppBloc.homeCubit.getCalledExternally()) {
                _setSavedCity(location!);
                AppBloc.homeCubit.setCalledExternally(false);
              }
            }
            if (AppBloc.homeCubit.getDoesScroll()) {
              AppBloc.homeCubit.setDoesScroll(false);
              scrollUp();
            }
          }

          if (state is HomeStatecategoryLoading) {
            categoryLoading = true;
            location = state.location;
            if (location!.isNotEmpty) {
              for (final ids in location!) {
                cityTitles.add(ids.title.toString());
              }
              if (checkSavedCity) {
                checkSavedCity = false;
                _setSavedCity(location!);
              }
            }
          }

          return UpgradeAlert(
            upgrader: ignoreAppStoreVersion == latestAppStoreVersion
                ? null
                : Upgrader(
                    debugLogging: true,
                    debugDisplayAlways: true,
                    countryCode: 'DE',
                    showLater: false,
                    shouldPopScope: () => true,
                    canDismissDialog: true,
                    durationUntilAlertAgain: const Duration(seconds: 30),
                    dialogStyle: Platform.isIOS
                        ? UpgradeDialogStyle.cupertino
                        : UpgradeDialogStyle.material,
                    willDisplayUpgrade: (
                        {String? appStoreVersion,
                        bool? display,
                        String? installedVersion,
                        String? minAppVersion}) {
                      if (display != null) {
                        setState(() {
                          latestAppStoreVersion = appStoreVersion ?? '2.4.3';
                        });
                      }
                    },
                    onUpdate: () {
                      return true;
                    },
                    onIgnore: () {
                      AppBloc.homeCubit
                          .saveIgnoreAppVersion(latestAppStoreVersion);
                      return true;
                    }),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: AppBarHomeSliver(
                      cityTitlesList: cityTitles,
                      hintText:
                          Translate.of(context).translate('hselect_location'),
                      selectedOption: (selectedCityId > 0)
                          ? selectedCityTitle
                          : Translate.of(context).translate('select_location'),
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      banners: banner,
                      setLocationCallback: (data) async {
                        for (final list in location!) {
                          if (list.title == data) {
                            _onUpdateCategory();
                            setState(() {
                              selectedCityTitle = data;
                              selectedCityId = list.id;
                            });
                            await AppBloc.discoveryCubit
                                .onLocationFilter(selectedCityId, false);
                          } else if (data ==
                              Translate.of(context)
                                  .translate('select_location')) {
                            setState(() {
                              selectedCityId = 0;
                            });
                            _onUpdateCategory();
                            AppBloc.homeCubit.saveCityId(selectedCityId);
                            await AppBloc.discoveryCubit
                                .onLocationFilter(selectedCityId, false);
                            break;
                          }
                        }
                      }),
                  pinned: true,
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: _onRefresh,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Column(
                        children: <Widget>[
                          categoryLoading
                              ? const CircularProgressIndicator.adaptive()
                              : _buildCategory(AppBloc.homeCubit
                                  .getCategoriesWithoutHidden(category ?? [])),
                          _buildLocation(location),
                          _buildRecent(recent, selectedCityId, location),
                          if (isLoading)
                            const CircularProgressIndicator.adaptive(),
                          const SizedBox(height: 50),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onPopUpCatError() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(Translate.of(context).translate('categorization')),
        content: Text(Translate.of(context).translate("category_coming_soon")),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCitySelectionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('input_city')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Translate.of(context).translate('please_select_city')),
              const SizedBox(height: 16),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onCategory(
      CategoryModel item, List<CategoryModel> listBuild) async {
    if (item.id == -1) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        Translate.of(context).translate('all_Categories'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Wrap(
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: listBuild.map(
                    (item) {
                      return HomeCategoryItem(
                        item: item,
                        onPressed: (item) {
                          _onCategory(item, listBuild);
                          return false;
                        },
                        // _onCategory,
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          );
        },
      );
      return;
    }

    if (item.id != -1) {
      if (item.id == 17) {
        final cityId = await context.read<DiscoveryCubit>().getCitySelected();
        if (cityId != 0) {
          if (!mounted) return;
          Navigator.pushNamed(context, Routes.listGroups,
              arguments: {'id': item.id, 'title': 'Gruppen'});
        } else {
          if (!mounted) return;
          _showCitySelectionPopup(context);
        }
      } else {
        final prefs = await Preferences.openBox();
        prefs.setKeyValue(Preferences.categoryId, item.id);
        prefs.setKeyValue(Preferences.type, "category");
        if (!mounted) return;
        Navigator.pushNamed(context, Routes.listProduct,
            arguments: {'id': selectedCityId, 'title': ''});
      }
    } else if (item.id != -1 && !item.hasChild) {
      _onPopUpCatError();
    }
  }

  Future<void> _onLocation(CategoryModel item) async {
    if (item.id == -1) {
      _onPopUpCatError();
      return;
    }

    if (item.id != -1) {
      final prefs = await Preferences.openBox();
      prefs.setKeyValue(Preferences.type, "location");
      if (!mounted) return;
      Navigator.pushNamed(context, Routes.listProduct,
          arguments: {'id': item.id, 'title': item.title});
    } else if (item.id != -1 && !item.hasChild) {
      _onPopUpCatError();
    }
  }

  void _makeAction(String link) async {
    if (!link.startsWith("https://") && !link.startsWith("http://")) {
      link = "https://$link";
    }
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(link));

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        link,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 30,
                child: WebViewWidget(
                  controller: webViewController,
                  gestureRecognizers: gestureRecognizers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onProductDetail(ProductModel item) {
    if (item.sourceId == 2 || item.showExternal == 1) {
      _makeAction(item.website);
    } else if (item.showExternal == 0) {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    }
  }

  Widget _buildCategory(List<CategoryModel>? category) {
    Widget content = Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) => index).map(
        (item) {
          return const HomeCategoryItem();
        },
      ).toList(),
    );

    if (category != null) {
      List<CategoryModel> listBuild = category;
      final more = CategoryModel.fromJson({
        "id": -1,
        "name": Translate.of(context).translate("more"),
        "icon": "fas fa-ellipsis",
        "color": "#36454F",
      });

      if (category.length >= 7) {
        listBuild = category.take(7).toList();
        listBuild.add(more);
      }

      content = Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: listBuild.map(
          (item) {
            return HomeCategoryItem(
              item: item,
              onPressed: (item) {
                _onCategory(item, category);
                return false;
              },
            );
          },
        ).toList(),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: content,
    );
  }

  Widget _buildLocation(List<CategoryModel>? location) {
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppCategory(
            type: CategoryView.cardLarge,
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );
    if (location != null) {
      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = location[index];
          return selectedCityId != 0
              ? Visibility(
                  visible: item.title != selectedCityTitle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AppCategory(
                      item: item,
                      type: CategoryView.cardLarge,
                      onPressed: () {
                        _onLocation(item);
                      },
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AppCategory(
                    item: item,
                    type: CategoryView.cardLarge,
                    onPressed: () {
                      _onLocation(item);
                    },
                  ),
                );
        },
        itemCount: location.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate(
                  'popular_location',
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'let_find_interesting',
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  Widget _buildRecent(List<ProductModel>? recent, int selectedCity,
      List<CategoryModel>? cities) {
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppProductItem(
              type: ProductViewType.small, isRefreshLoader: isRefreshLoader),
        );
      },
      itemCount: 8,
    );

    if (recent != null) {
      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = recent[index];
          return selectedCityId != 0
              ? Visibility(
                  visible: recent[index].cityId == selectedCity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppProductItem(
                        onPressed: () {
                          _onProductDetail(item);
                        },
                        item: item,
                        type: ProductViewType.small,
                        isRefreshLoader: isRefreshLoader,
                        cityName: AppBloc.homeCubit
                            .getCityName(cities, item.cityId ?? 0)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppProductItem(
                      onPressed: () {
                        _onProductDetail(item);
                      },
                      isRefreshLoader: isRefreshLoader,
                      item: item,
                      type: ProductViewType.small,
                      cityName: AppBloc.homeCubit
                          .getCityName(cities, item.cityId ?? 0)),
                );
        },
        itemCount: recent.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('recent_listings'),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'what_happen',
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content,
        ),
      ],
    );
  }
}

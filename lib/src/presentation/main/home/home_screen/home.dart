import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/widget/home_category_item.dart';
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_category_item.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

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

  @override
  void initState() {
    super.initState();
    AppBloc.homeCubit.onLoad();
    connectivityInternet();
  }

  void connectivityInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      AppBloc.homeCubit.onLoad();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await AppBloc.homeCubit.onLoad();
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
          List<String>? banner;
          List<CategoryModel>? category;
          List<CategoryModel>? location;
          List<ProductModel>? recent;
          List<String> cityTitles = [
            Translate.of(context).translate('select_location')
          ];

          if (state is HomeStateLoaded) {
            banner = state.banner;
            category = state.category;
            location = state.location;
            recent = state.recent;

            if (location.isNotEmpty) {
              for (final ids in location) {
                cityTitles.add(ids.title.toString());
              }
            }
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: AppBarHomeSliver(
                  cityTitlesList: cityTitles,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  banners: banner,
                  setLocationCallback: (data) async {
                    for (final list in location!) {
                      if (list.title == data) {
                        setState(() {
                          selectedCityTitle = data;
                          selectedCityId = list.id;
                        });
                      } else if (data ==
                          Translate.of(context).translate('select_location')) {
                        setState(() {
                          selectedCityId = 0;
                        });
                      }
                    }
                  },
                ),
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
                        _buildCategory(category),
                        _buildLocation(location),
                        _buildRecent(recent, selectedCityId),
                        const SizedBox(height: 28),
                      ],
                    ),
                  )
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  void _onPopUpCatError() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Kategorisierung'),
        content: const Text(
            'Diese Funktion wird in Kürze fertiggestellt. Durch die Kategorien hast du die Möglichkeit deine Interessen zu filtern. Es werden dir dann nur die relevanten Informationen angezeigt.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
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
      final prefs = await Preferences.openBox();
      prefs.setKeyValue(Preferences.categoryId, item.id);
      prefs.setKeyValue(Preferences.categoryId, item.id);
      prefs.setKeyValue(Preferences.type, "category");
      if (!mounted) return;
      Navigator.pushNamed(context, Routes.listProduct,
          arguments: selectedCityId);
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
      prefs.setKeyValue(Preferences.cityId, item.id);
      prefs.setKeyValue(Preferences.type, "location");
      if (!mounted) return;
      Navigator.pushNamed(context, Routes.listProduct, arguments: item.id);
    } else if (item.id != -1 && !item.hasChild) {
      _onPopUpCatError();
    }
  }

  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
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
        "color": "#ff8a65",
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

  Widget _buildRecent(List<ProductModel>? recent, int selectedCity) {
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppProductItem(type: ProductViewType.small),
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
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppProductItem(
                    onPressed: () {
                      _onProductDetail(item);
                    },
                    item: item,
                    type: ProductViewType.small,
                  ),
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

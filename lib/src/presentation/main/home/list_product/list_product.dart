import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/widget/app_navbar.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'cubit/cubit.dart';

class ListProductScreen extends StatefulWidget {
  final int selectedCityId;

  const ListProductScreen({Key? key, required this.selectedCityId})
      : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final _listCubit = ListCubit();
  final _swipeController = SwiperController();
  final _scrollController = ScrollController();

  final PageType _pageType = PageType.list;
  final ProductViewType _listMode = Application.setting.listMode;
  ProductFilter? selectedFilter;

  @override
  void initState() {
    super.initState();
    loadListingsList();
  }

  @override
  void dispose() {
    _swipeController.dispose();
    _scrollController.dispose();
    _listCubit.close();
    super.dispose();
  }

  Future<void> loadListingsList() async {
    await _listCubit.onLoad(widget.selectedCityId);
  }

  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  void _openFilterDrawer() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[900],
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        _updateSelectedFilter(ProductFilter.week);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            Translate.of(context).translate('this_week'),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          _buildTickIcon(selectedFilter == ProductFilter.week),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        _updateSelectedFilter(ProductFilter.month);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            Translate.of(context).translate('this_month'),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          _buildTickIcon(selectedFilter == ProductFilter.month),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedFilter(ProductFilter? filter) {
    setState(() {
      if (selectedFilter == filter) {
        selectedFilter = null;
        _listCubit.onProductFilter(null);
      } else {
        selectedFilter = filter;
        _listCubit.onProductFilter(filter);
      }
    });
  }

  Widget _buildTickIcon(bool isSelected) {
    return isSelected
        ? const Icon(
            Icons.done,
            color: Colors.white,
            size: 20,
            weight: 900,
          )
        : const SizedBox(width: 20);
  }

  Widget _buildItem({
    ProductModel? item,
    required ProductViewType type,
  }) {
    switch (type) {
      case ProductViewType.list:
        if (item != null) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppProductItem(
              onPressed: () {
                _onProductDetail(item);
              },
              item: item,
              type: _listMode,
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppProductItem(
            type: _listMode,
          ),
        );
      default:
        if (item != null) {
          return AppProductItem(
            onPressed: () {
              _onProductDetail(item);
            },
            item: item,
            type: _listMode,
          );
        }
        return AppProductItem(
          type: _listMode,
        );
    }
  }

  Widget _buildContent() {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        if (_pageType == PageType.list) {
          Widget contentList = ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildItem(type: _listMode),
              );
            },
            itemCount: 8,
          );
          if (_listMode == ProductViewType.grid) {
            final size = MediaQuery.of(context).size;
            final left = MediaQuery.of(context).padding.left;
            final right = MediaQuery.of(context).padding.right;
            const itemHeight = 220;
            final itemWidth = (size.width - 48 - left - right) / 2;
            final ratio = itemWidth / itemHeight;
            contentList = GridView.count(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: ratio,
              children: List.generate(8, (index) => index).map((item) {
                return _buildItem(type: _listMode);
              }).toList(),
            );
          }

          if (state is ListStateLoaded) {
            List list = List.from(state.list);
            contentList = RefreshIndicator(
              onRefresh: loadListingsList,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildItem(item: item, type: _listMode),
                  );
                },
                itemCount: list.length,
              ),
            );
            if (_listMode == ProductViewType.grid) {
              final size = MediaQuery.of(context).size;
              final left = MediaQuery.of(context).padding.left;
              final right = MediaQuery.of(context).padding.right;
              const itemHeight = 220;
              final itemWidth = (size.width - 48 - left - right) / 2;
              final ratio = itemWidth / itemHeight;
              contentList = RefreshIndicator(
                onRefresh: loadListingsList,
                child: GridView.count(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: ratio,
                  children: list.map((item) {
                    return _buildItem(item: item, type: _listMode);
                  }).toList(),
                ),
              );
            }

            if (state.list.isEmpty) {
              contentList = Center(
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
              );
            }
          }
          return SafeArea(child: contentList);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _listCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Translate.of(context).translate('listing')),
          actions: [
            BlocBuilder<ListCubit, ListState>(
              builder: (context, state) {
                return FutureBuilder<bool?>(
                  future: _listCubit.categoryPreferencesCall(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Container();
                    } else {
                      bool isEvent = snapshot.data!;
                      return isEvent
                          ? IconButton(
                              icon: const Icon(Icons.filter_list),
                              onPressed: _openFilterDrawer,
                            )
                          : Container();
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _buildContent(),
            )
          ],
        ),
      ),
    );
  }
}

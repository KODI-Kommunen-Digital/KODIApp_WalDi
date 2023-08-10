import 'dart:async';

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
  ProductFilter? selectedFilter;

  @override
  void initState() {
    super.initState();
    loadListingsList();
  }

  Future<void> loadListingsList() async {
    await context.read<ListCubit>().onLoad();
  }

  void _updateSelectedFilter(ProductFilter? filter) {
    final loadedList = context.read<ListCubit>().getLoadedList();
    setState(() {
      if (selectedFilter == filter) {
        selectedFilter = null;
        context.read<ListCubit>().onProductFilter(null, loadedList);
      } else {
        selectedFilter = filter;
        context.read<ListCubit>().onProductFilter(filter, loadedList);
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

  Future<void> _openFilterDrawer(BuildContext context) async {
    await showModalBottomSheet(
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
    // await loadListingsList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FutureBuilder<String?>(
              future: context.read<ListCubit>().getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Container();
                } else {
                  String category = snapshot.data!;
                  return Text(Translate.of(context).translate(category));
                }
              }),
          actions: [
            FutureBuilder<bool?>(
              future: context.read<ListCubit>().categoryPreferencesCall(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Container();
                } else {
                  bool isEvent = snapshot.data!;
                  return isEvent
                      ? TextButton(
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
                        )
                      : Container();
                }
              },
            ),
          ],
        ),
        body: BlocConsumer<ListCubit, ListState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (msg) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg))),
              orElse: () {},
            );
          },
          builder: (context, state) => state.when(
            loading: () => const ListLoading(),
            loaded: (list) => ListLoaded(
              list: list,
              selectedCityId: widget.selectedCityId,
            ),
            updated: (list) {
              return ListLoaded(
                list: list,
                selectedCityId: widget.selectedCityId,
              );
            },
            error: (e) => ErrorWidget('Failed to load listings.'),
            initial: () {
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ListLoaded extends StatefulWidget {
  final List<ProductModel> list;
  final int selectedCityId;

  const ListLoaded({
    Key? key,
    required this.list,
    required this.selectedCityId,
  }) : super(key: key);

  @override
  State<ListLoaded> createState() => _ListLoadedState();
}

class _ListLoadedState extends State<ListLoaded> {
  // final _swipeController = SwiperController();
  final _scrollController = ScrollController();
  bool isLoading = false;
  final PageType _pageType = PageType.list;
  final ProductViewType _listMode = Application.setting.listMode;

  @override
  void initState() {
    super.initState();
    // loadListingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildContent(widget.list),
        )
      ],
    );
  }

  Future<void> loadListingsList() async {
    setState(() {
      isLoading = true;
    });
    await context.read<ListCubit>().onLoad();
    setState(() {
      isLoading = false;
    });
  }

  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
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

  Widget _buildContent(List<ProductModel> list) {
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

          if (list.isEmpty) {
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

          return SafeArea(child: contentList);
        }
        return Container();
      },
    );
  }
}

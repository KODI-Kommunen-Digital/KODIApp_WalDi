// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/widget/app_filter_button.dart';
import 'package:heidi/src/presentation/widget/app_navbar.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/cubit.dart';

class ListProductScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const ListProductScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  ProductFilter? selectedFilter;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    loadListingsList();
  }

  Future<void> loadListingsList() async {
    await context.read<ListCubit>().onLoad(widget.arguments['id']);
  }

  void _updateSelectedFilter(ProductFilter? filter) {
    selectedFilter = filter;
    final loadedList = context.read<ListCubit>().getLoadedList();
    setState(() {
      context.read<ListCubit>().onProductFilter(filter, loadedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: widget.arguments['title'] != ''
              ? Text(widget.arguments['title'])
              : FutureBuilder<String?>(
                  future: context.read<ListCubit>().getCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
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
                  return const CircularProgressIndicator.adaptive();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Container();
                } else {
                  bool isEvent = snapshot.data!;
                  return isEvent
                      ? AppFilterButton(
                          multiFilter: MultiFilter(
                              hasProductEventFilter: true,
                              currentProductEventFilter: selectedFilter),
                          filterCallBack: (filter) {
                            _updateSelectedFilter(
                                filter.currentProductEventFilter);
                          })
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
            loaded: (list, listCity) => ListLoaded(
              list: list,
              listCity: listCity,
              selectedId: widget.arguments['id'],
            ),
            updated: (list, listCity) {
              return ListLoaded(
                list: list,
                listCity: listCity,
                selectedId: widget.arguments['id'],
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
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class ListLoaded extends StatefulWidget {
  final List<ProductModel> list;
  final int selectedId;
  final List listCity;

  const ListLoaded(
      {Key? key,
      required this.list,
      required this.selectedId,
      required this.listCity})
      : super(key: key);

  @override
  State<ListLoaded> createState() => _ListLoadedState();
}

class _ListLoadedState extends State<ListLoaded> {
  List<ProductModel> list = [];
  List listCity = [];
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  bool isLoading = false;
  bool isLoadingMore = false;
  final PageType _pageType = PageType.list;
  final ProductViewType _listMode = Application.setting.listMode;
  double previousScrollPosition = 0;
  int pageNo = 1;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    //loadListingsList();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
          // previousScrollPosition = _scrollController.position.pixels;
        });
        list = await context
            .read<ListCubit>()
            .newListings(++pageNo, widget.selectedId);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildContent(),
        )
      ],
    );
  }

  Future<void> loadListingsList() async {
    setState(() {
      isLoading = true;
    });
    await context.read<ListCubit>().onLoad(widget.selectedId);
    setState(() {
      isLoading = false;
    });
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
              isRefreshLoader: true,
              cityName: context
                  .read<ListCubit>()
                  .getCityNameFromId(widget.listCity, item.cityId ?? 0),
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
            isRefreshLoader: true,
            type: _listMode,
          ),
        );
      default:
        if (item != null) {
          return AppProductItem(
            isRefreshLoader: true,
            onPressed: () {
              _onProductDetail(item);
            },
            item: item,
            type: _listMode,
          );
        }
        return AppProductItem(
          isRefreshLoader: true,
          type: _listMode,
        );
    }
  }

  Widget _buildContent() {
    list = widget.list;
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        if (_pageType == PageType.list) {
          Widget contentList = CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = list[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 5),
                      child: _buildItem(item: item, type: _listMode),
                    );
                  },
                  childCount: list.length,
                ),
              ),
            ],
          );

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

          return SafeArea(
            child: Stack(
              children: [
                contentList,
                if (isLoadingMore)
                  const Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

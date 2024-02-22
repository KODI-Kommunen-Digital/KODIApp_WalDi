// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_cubit.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_state.dart';
import 'package:heidi/src/presentation/widget/app_filter_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class AllListingsScreen extends StatefulWidget {
  final UserModel user;

  const AllListingsScreen({required this.user, super.key});

  @override
  State<AllListingsScreen> createState() => _AllListingsScreenState();
}

class _AllListingsScreenState extends State<AllListingsScreen> {
  @override
  void dispose() {
    AppBloc.allListingsCubit.setCurrentStatus(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllListingsCubit, AllListingsState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const AllListingsLoading(),
            loaded: (posts, currentFilter) => AllListingsLoaded(
                  user: widget.user,
                  posts: posts,
                  currentFilter: currentFilter,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class AllListingsLoading extends StatelessWidget {
  const AllListingsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('all_listings'),
          ),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}

class AllListingsLoaded extends StatefulWidget {
  final List<ProductModel>? posts;
  final UserModel user;
  final int currentFilter;

  const AllListingsLoaded(
      {required this.user, this.posts, super.key, required this.currentFilter});

  @override
  State<AllListingsLoaded> createState() => _AllListingsLoadedState();
}

class _AllListingsLoadedState extends State<AllListingsLoaded> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  double previousScrollPosition = 0;
  bool isLoadingMore = false;
  int pageNo = 1;
  List<ProductModel>? posts;
  bool isSwiped = false;
  String selectedListingStatusValue = "inactive";
  late int currentFilter;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    posts = widget.posts;
    currentFilter = widget.currentFilter;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('all_listings'),
        ),
        actions: [
          AppFilterButton(
              multiFilter: MultiFilter(
                  hasListingStatusFilter: true,
                  currentListingStatus: currentFilter),
              filterCallBack: (filter) async {
                await AppBloc.allListingsCubit
                    .setCurrentStatus(filter.currentListingStatus!);
                await _onRefresh();
              }),
        ],
      ),
      body: Stack(children: [
        (posts?.isNotEmpty ?? false)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 0),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: _scrollController,
                  slivers: <Widget>[
                    CupertinoSliverRefreshControl(
                      onRefresh: _onRefreshLoader,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index < posts!.length) {
                            final item = posts![index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (aContext) {
                                      Navigator.pushNamed(
                                          context, Routes.submit, arguments: {
                                        'item': item,
                                        'isNewList': false,
                                        'isAdmin': true
                                      }).then((value) async {
                                        await _onRefresh();
                                      });
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label:
                                        Translate.of(context).translate('edit'),
                                  ),
                                  SlidableAction(
                                    onPressed: (aContext) async {
                                      bool response =
                                          await showDeleteConfirmation(
                                              context, item);
                                      if (response) {
                                        await AppBloc.homeCubit
                                            .onLoad(false)
                                            .then((value) => _onRefresh());
                                      }
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: Translate.of(context)
                                        .translate('delete'),
                                  ),
                                ],
                              ),
                              key:
                                  Key(item.id.toString() + isSwiped.toString()),
                              child: InkWell(
                                onTap: () {
                                  _onProductDetail(item);
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
                                            child: CachedNetworkImage(
                                              imageUrl: item.sourceId == 2 ||
                                                      item.sourceId == 3
                                                  ? item.image
                                                  : "${Application.picturesURL}${item.image}",
                                              cacheManager: memoryCacheManager,
                                              placeholder: (context, url) {
                                                return AppPlaceholder(
                                                  child: Container(
                                                    height: 140,
                                                    width: 120,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  width: 120,
                                                  height: 140,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return AppPlaceholder(
                                                  child: Container(
                                                    width: 120,
                                                    height: 140,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                    child:
                                                        const Icon(Icons.error),
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
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                Text(
                                                  item.category ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  item.title,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  item.categoryId == 3
                                                      ? (item.endDate != ""
                                                          ? "${item.startDate} ${Translate.of(context).translate('to')} ${item.endDate}"
                                                          : item.startDate)
                                                      : item.createDate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          _openListingStatusActionPopUp(
                                                              item);
                                                        },
                                                        child: Text(
                                                          Translate.of(context)
                                                              .translate(
                                                                  getStatusTanslation(
                                                                      item.statusId ??
                                                                          0,
                                                                      null)),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          _openListingActionPopUp(
                                                              item);
                                                        },
                                                        icon: const Icon(
                                                            Icons.more_vert))
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                const SizedBox(height: 4),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            (isLoadingMore)
                                ? const Positioned(
                                    bottom: 20,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  )
                                : Container();
                          }
                          return null;
                        },
                        childCount: posts!.length + 1,
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

  Future _onListingAction(int? chosen, ProductModel item) async {
    if (chosen == null) return;

    switch (chosen) {
      case 1:
        Navigator.pushNamed(context, Routes.submit,
                arguments: {'item': item, 'isNewList': false, 'isAdmin': true})
            .then((value) async {
          await _onRefresh();
        });
        break;
      case 2:
        bool response = await showDeleteConfirmation(context, item);
        if (response) {
          await AppBloc.homeCubit.onLoad(false).then((value) => _onRefresh());
        }
        break;
    }
  }

  void _openListingActionPopUp(ProductModel item) {
    selectedListingStatusValue = Translate.of(context)
        .translate(getStatusTanslation(item.statusId!, null));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<AddListingCubit, AddListingState>(
            builder: (context, state) => state.maybeWhen(loading: () {
                  return const CircularProgressIndicator();
                }, loaded: () {
                  return SimpleDialog(
                      title: Center(
                        child: Text(Translate.of(context).translate('options'),
                            style: TextStyle(
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color ??
                                  Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _onListingAction(1, item);
                          },
                          child: ListTile(
                            leading: const Icon(Icons.edit),
                            title:
                                Text(Translate.of(context).translate('edit')),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _onListingAction(2, item);
                          },
                          child: ListTile(
                            leading: const Icon(Icons.delete),
                            title:
                                Text(Translate.of(context).translate('delete')),
                          ),
                        ),
                      ]);
                }, orElse: () {
                  return AlertDialog(
                    title: Text(Translate.of(context).translate("error")),
                    content: Text(Translate.of(context)
                        .translate("cannot_connect_to_server")),
                  );
                }));
      },
    );
  }

  void _openListingStatusActionPopUp(ProductModel item) {
    selectedListingStatusValue = Translate.of(context)
        .translate(getStatusTanslation(item.statusId!, null));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<AddListingCubit, AddListingState>(
            builder: (context, state) => state.maybeWhen(loading: () {
                  return const CircularProgressIndicator();
                }, loaded: () {
                  return SimpleDialog(
                      title: Center(
                        child: Text(Translate.of(context).translate('status'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      children: [
                        SimpleDialogOption(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: false,
                              hint: Text(Translate.of(context)
                                  .translate('change_status')),
                              value: selectedListingStatusValue,
                              onChanged: (chosen) async {
                                int choice = int.parse(
                                    getStatusTanslation(null, chosen));
                                await context
                                    .read<AddListingCubit>()
                                    .changeStatus(item, choice);
                                selectedListingStatusValue =
                                    Translate.of(context)
                                        .translate(chosen ?? "inactive");
                                Navigator.of(context).pop();
                                _onRefresh();
                                AppBloc.homeCubit.onLoad(true);
                              },
                              items: [
                                DropdownMenuItem<String>(
                                    value: Translate.of(context)
                                        .translate('active'),
                                    child: Text(Translate.of(context)
                                        .translate('active'))),
                                DropdownMenuItem<String>(
                                  value: Translate.of(context)
                                      .translate('inactive'),
                                  child: Text(Translate.of(context)
                                      .translate('inactive')),
                                ),
                                DropdownMenuItem<String>(
                                  value: Translate.of(context)
                                      .translate('under_review'),
                                  child: Text(Translate.of(context)
                                      .translate('under_review')),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]);
                }, orElse: () {
                  return AlertDialog(
                    title: Text(Translate.of(context).translate("error")),
                    content: Text(Translate.of(context)
                        .translate("cannot_connect_to_server")),
                  );
                }));
      },
    );
  }

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
          //previousScrollPosition = _scrollController.position.pixels;
        });
        posts = await context.read<AllListingsCubit>().newListings(++pageNo);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  Future<bool> showDeleteConfirmation(
      BuildContext context, ProductModel item) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(Translate.of(context)
              .translate('Are_you_sure_you_want_to_delete_this_item?')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              }, // Yes
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // No
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );
    if (result == true) {
      if (!mounted) return false;
      final deleteResponse =
          await context.read<AllListingsCubit>().deleteUserList(
                item.cityId,
                item.id,
              );
      return deleteResponse;
    }
    return false;
  }

  Future _onRefresh() async {
    await context.read<AllListingsCubit>().onLoad(false);
  }

  Future _onRefreshLoader() async {
    await context.read<AllListingsCubit>().onLoad(true);
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

  String getStatusTanslation(int? statusId, String? statusName) {
    if (statusId != null) {
      switch (statusId) {
        case 1:
          return "active";
        case 2:
          return "inactive";
        case 3:
          return "under_review";
      }
    } else if (statusName != null) {
      if (statusName == Translate.of(context).translate('active')) {
        return "1";
      } else if (statusName == Translate.of(context).translate('inactive')) {
        return "2";
      } else if (statusName ==
          Translate.of(context).translate('under_review')) {
        return "3";
      }
    }

    return "";
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
}

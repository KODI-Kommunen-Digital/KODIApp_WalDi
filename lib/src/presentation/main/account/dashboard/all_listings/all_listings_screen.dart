// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class AllListingsScreen extends StatelessWidget {
  final UserModel user;

  const AllListingsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    if (user.roleId == 1) {
      return BlocBuilder<AllListingsCubit, AllListingsState>(
          builder: (context, state) => state.maybeWhen(
              loading: () => const AllListingsLoading(),
              loaded: (posts) => AllListingsLoaded(
                    user: user,
                    posts: posts,
                  ),
              orElse: () => ErrorWidget("Failed to load listings.")));
    }
    return const AllListingsBlocked();
  }
}

class AllListingsLoading extends StatelessWidget {
  const AllListingsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class AllListingsLoaded extends StatefulWidget {
  final List<ProductModel>? posts;
  final UserModel user;

  const AllListingsLoaded({required this.user, this.posts, super.key});

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
  int selectedStatus = 0;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    posts = widget.posts;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openFilterDrawer(BuildContext context) async {
    List<String> statusNames = [
      Translate.of(context).translate("active"),
      Translate.of(context).translate("under_review"),
      Translate.of(context).translate("pending")
    ];
    int selectedStatus = await AppBloc.allListingsCubit.getCurrentStatus();
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[900],
          height: 200,
          child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.white,
              height: 1,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(statusNames[index]),
                trailing: (selectedStatus == index + 1)
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () async {
                  if (selectedStatus != index + 1) {
                    await AppBloc.allListingsCubit.setCurrentStatus(index + 1);
                  } else {
                    await AppBloc.allListingsCubit.setCurrentStatus(0);
                  }
                  Navigator.of(context).pop();
                  await _onRefresh();
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    final memoryCacheManager = DefaultCacheManager();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('all_listings'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              _openFilterDrawer(context);
            },
            style: TextButton.styleFrom(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            child: const Text(
              "Filter"
            ),
          ),
        ],
      ),
      body: Stack(children: [
        (posts?.isNotEmpty ?? false)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 50),
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
                          final item = posts![index];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (aContext) {
                                    Navigator.pushNamed(context, Routes.submit,
                                        arguments: {
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
                                  label:
                                      Translate.of(context).translate('delete'),
                                ),
                              ],
                            ),
                            key: Key(item.id.toString() + isSwiped.toString()),
                            child: InkWell(
                              onTap: () {
                                _onProductDetail(item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          item.pdf == ''
                                              ? CachedNetworkImage(
                                                  imageUrl: item.sourceId == 2
                                                      ? item.image
                                                      : item.image ==
                                                              'admin/News.jpeg'
                                                          ? "${Application.picturesURL}${item.image}"
                                                          : "${Application.picturesURL}${item.image}?cacheKey=$uniqueKey",
                                                  cacheManager:
                                                      memoryCacheManager,
                                                  imageBuilder:
                                                      (context, imageProvider) {
                                                    return Container(
                                                      width: 120,
                                                      height: 140,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
                                                      ),
                                                    );
                                                  },
                                                  placeholder: (context, url) {
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
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                          ),
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
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                            Icons.error),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(11),
                                                  child: SizedBox(
                                                      width: 120,
                                                      height: 140,
                                                      child: const PDF()
                                                          .cachedFromUrl(
                                                        "${Application.picturesURL}${item.pdf}?cacheKey=$uniqueKey",
                                                        placeholder:
                                                            (progress) => Center(
                                                                child: Text(
                                                                    '$progress %')),
                                                        errorWidget: (error) =>
                                                            Center(
                                                                child: Text(error
                                                                    .toString())),
                                                      )),
                                                ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
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
                                                      ? "${item.startDate} ${Translate.of(context).translate('to')} ${item.endDate}"
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
                                                Text(
                                                  Translate.of(context)
                                                      .translate(
                                                          getStatusTanslation(
                                                              item.statusId ??
                                                                  0)),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
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
                            ),
                          );
                        },
                        childCount: posts!.length,
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
        (isLoadingMore)
            ? const Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : Container()
      ]),
    ));
  }

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
          previousScrollPosition = _scrollController.position.pixels;
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
    await context.read<AllListingsCubit>().onLoad();
  }

  void _onProductDetail(ProductModel item) {
    if (item.sourceId == 2) {
      _makeAction(item.website);
    } else {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    }
  }

  String getStatusTanslation(int statusId) {
    if (statusId == 1) {
      return "active";
    } else if (statusId == 2) {
      return "under_review";
    } else if (statusId == 3) {
      return "pending";
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

class AllListingsBlocked extends StatelessWidget {
  const AllListingsBlocked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('all_listings'),
        ),
      ),
      body: Center(
          child: Text(
        Translate.of(context).translate('all_listings_not_admin'),
        overflow: TextOverflow.fade,
      )),
    );
  }
}

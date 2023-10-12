import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';

class AllListingsScreen extends StatelessWidget {
  final UserModel user;

  const AllListingsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    if (user.roleId == 1) {
      return BlocBuilder<AllListingsCubit, AllListingsState>(
          builder: (context, state) => state.maybeWhen(
              loading: () => const AllListingsLoading(),
              loaded: (posts) => AllListingsLoaded(user: user, posts: posts),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('all_listings'),
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        (posts?.isNotEmpty ?? false)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AppProductItem(
                              onPressed: () {
                                _onProductDetail(item);
                              },
                              isRefreshLoader: false,
                              item: item,
                              type: ProductViewType.small,
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
      ])),
    );
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
        )));
  }
}

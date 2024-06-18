import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:heidi/src/data/model/model_favorites_detail_list.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'cubit/cubit.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishListCubit, WishListState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const WishListLoading(),
        loaded: (favoritesList) => WishListLoaded(favoritesList: favoritesList),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class WishListLoading extends StatelessWidget {
  const WishListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class WishListLoaded extends StatefulWidget {
  final List<FavoriteDetailsModel> favoritesList;

  const WishListLoaded({
    Key? key,
    required this.favoritesList,
  }) : super(key: key);

  @override
  State<WishListLoaded> createState() => _WishListLoadedState();
}

class _WishListLoadedState extends State<WishListLoaded> {
  bool isLoading = false;
  final _scrollController = ScrollController();
  final memoryCacheManager = DefaultCacheManager();

  void scrollUp() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('wish_list')),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Stack(children: [
          Center(
            child: Visibility(
              visible: isLoading,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          BlocListener<WishListCubit, WishListState>(
            listener: (context, state) {
              if (AppBloc.wishListCubit.getDoesScroll()) {
                AppBloc.wishListCubit.setDoesScroll(false);
                scrollUp();
              }
            },
            child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 8),
                itemCount: widget.favoritesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          openWishlistDetails(
                              context, widget.favoritesList[index]);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: <Widget>[
                                widget.favoritesList[index].pdf == ''
                                    ? CachedNetworkImage(
                                        imageUrl: widget.favoritesList[index]
                                                    .sourceId ==
                                                2
                                            ? "${Application.picturesURL}${widget.favoritesList[index].logo}"
                                            : (widget.favoritesList[index]
                                                        .logo ==
                                                    null
                                                ? "${Application.picturesURL}admin/News.jpeg"
                                                : "${Application.picturesURL}${widget.favoritesList[index].logo}"),
                                        cacheManager: memoryCacheManager,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: 120,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return AppPlaceholder(
                                            child: Container(
                                              width: 120,
                                              height: 140,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return AppPlaceholder(
                                            child: Container(
                                              width: 120,
                                              height: 140,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                              child: const Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(
                                        width: 120,
                                        height: 140,
                                        child: const PDF().cachedFromUrl(
                                          "${Application.picturesURL}${widget.favoritesList[index].pdf}?cacheKey=$uniqueKey",
                                          placeholder: (progress) => Center(
                                              child: Text('$progress %')),
                                          errorWidget: (error) => Center(
                                              child: Text(error.toString())),
                                        )),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.favoritesList[index].category!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.favoritesList[index].title,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.favoritesList[index]
                                                    .categoryId ==
                                                1
                                            ? WishListCubit().onDateParse(widget
                                                .favoritesList[index].createdAt)
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
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
                  );
                }),
          ),
        ]),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<WishListCubit>().onLoad();
  }

  void openWishlistDetails(
      BuildContext context, FavoriteDetailsModel favoritesList) {
    ProductModel product = ProductModel(
        id: favoritesList.id,
        title: favoritesList.title,
        image: favoritesList.logo ?? 'admin/News.jpeg',
        description: favoritesList.description,
        userId: favoritesList.userId,
        statusId: favoritesList.statusId!,
        address: favoritesList.address,
        phone: favoritesList.phone ?? '',
        website: favoritesList.website ?? '',
        externalId: favoritesList.externalId ?? '',
        email: favoritesList.email ?? '',
        favorite: true,
        cityId: favoritesList.cityId ?? 0,
        startDate: favoritesList.startDate ?? '',
        endDate: favoritesList.endDate ?? '',
        createDate: WishListCubit().onDateParse(favoritesList.createdAt),
        expiryDate: '');

    Navigator.pushNamed(context, Routes.productDetail, arguments: product)
        .then((value) async {
      setState(() {
        isLoading = true;
      });
      await context.read<WishListCubit>().onLoad();
      setState(() {
        isLoading = false;
      });
    });
  }
}

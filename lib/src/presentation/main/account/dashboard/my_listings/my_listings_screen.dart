import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_cubit.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class MyListingsScreen extends StatelessWidget {
  final UserModel user;
  final bool isEditable;

  const MyListingsScreen(
      {required this.user, required this.isEditable, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const ProfileLoading(),
        loaded: (userListing) => ProfileLoaded(user, userListing, isEditable),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class ProfileLoaded extends StatefulWidget {
  final UserModel user;
  final List<ProductModel> userListings;
  final bool isEditable;

  const ProfileLoaded(this.user, this.userListings, this.isEditable, {Key? key})
      : super(key: key);

  @override
  State<ProfileLoaded> createState() => _ProfileLoadedState();
}

class _ProfileLoadedState extends State<ProfileLoaded> {
  bool isLoading = false;
  bool isSwiped = false;
  bool isLoadingMore = false;
  int pageNo = 1;
  List<ProductModel> userListingsList = [];
  final _scrollController = ScrollController(initialScrollOffset: 0.0);

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    userListingsList.addAll(widget.userListings);
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    String uniqueKey = UniqueKey().toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('my_listings'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Stack(children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: userListingsList.length,
                        (BuildContext context, int index) {
                          final item = userListingsList[index];
                          return userListingsList == []
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Slidable(
                                      endActionPane: !widget.isEditable
                                          ? null
                                          : ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (aContext) {
                                                    Navigator.pushNamed(
                                                        context, Routes.submit,
                                                        arguments: {
                                                          'item':
                                                              userListingsList[
                                                                  index],
                                                          'isNewList': false
                                                        }).then((value) async {
                                                      final response =
                                                          await context
                                                              .read<
                                                                  ProfileCubit>()
                                                              .loadUserListing(
                                                                  widget
                                                                      .user.id,
                                                                  1);
                                                      setState(() {
                                                        userListingsList =
                                                            response;
                                                      });
                                                    });
                                                  },
                                                  backgroundColor: Colors.blue,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.edit,
                                                  label: Translate.of(context)
                                                      .translate('edit'),
                                                ),
                                                SlidableAction(
                                                  onPressed: (aContext) async {
                                                    showDeleteConfirmation(
                                                        context, index);
                                                  },
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: Translate.of(context)
                                                      .translate('delete'),
                                                ),
                                              ],
                                            ),
                                      key: Key(item.id.toString() +
                                          isSwiped.toString()),
                                      child: InkWell(
                                        onTap: () {
                                          _onProductDetail(item);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    item.pdf == ''
                                                        ? CachedNetworkImage(
                                                            imageUrl: item
                                                                        .sourceId ==
                                                                    2
                                                                ? item.image
                                                                : item.image ==
                                                                        'admin/News.jpeg'
                                                                    ? "${Application.picturesURL}${item.image}"
                                                                    : "${Application.picturesURL}${item.image}?cacheKey=$uniqueKey",
                                                            cacheManager:
                                                                memoryCacheManager,
                                                            imageBuilder: (context,
                                                                imageProvider) {
                                                              return Container(
                                                                width: 120,
                                                                height: 140,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              11),
                                                                ),
                                                              );
                                                            },
                                                            placeholder:
                                                                (context, url) {
                                                              return AppPlaceholder(
                                                                child:
                                                                    Container(
                                                                  width: 120,
                                                                  height: 140,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                (context, url,
                                                                    error) {
                                                              return AppPlaceholder(
                                                                child:
                                                                    Container(
                                                                  width: 120,
                                                                  height: 140,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  child: const Icon(
                                                                      Icons
                                                                          .error),
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11),
                                                            child: SizedBox(
                                                                width: 120,
                                                                height: 140,
                                                                child: const PDF()
                                                                    .cachedFromUrl(
                                                                  "${Application.picturesURL}${item.pdf}?cacheKey=$uniqueKey",
                                                                  placeholder:
                                                                      (progress) =>
                                                                          Center(
                                                                              child: Text('$progress %')),
                                                                  errorWidget:
                                                                      (error) =>
                                                                          Center(
                                                                              child: Text(error.toString())),
                                                                )),
                                                          ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            userListingsList[
                                                                        index]
                                                                    .category ??
                                                                '',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            userListingsList[
                                                                    index]
                                                                .title,
                                                            maxLines: 2,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            userListingsList[
                                                                            index]
                                                                        .categoryId ==
                                                                    3
                                                                ? "${userListingsList[index].startDate} ${Translate.of(context).translate('to')} ${userListingsList[index].endDate}"
                                                                : userListingsList[
                                                                        index]
                                                                    .createDate,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight, // Align to the right side
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                          8.0), // Add space only below the IconButton
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .more_vert),
                                                                onPressed: () {
                                                                  _showOptionsDialog(
                                                                      context,
                                                                      index);
                                                                },
                                                              ),
                                                            ),
                                                          ),
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
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                ),
                if (isLoadingMore)
                  const Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        userListingsList.addAll(await context
            .read<ProfileCubit>()
            .newListings(widget.user.id, ++pageNo));
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  Future<void> showDeleteConfirmation(BuildContext context, int index) async {
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
      if (!mounted) return;
      final deleteResponse = await context.read<ProfileCubit>().deleteUserList(
            userListingsList[index].cityId.toString(),
            userListingsList[index].id,
          );
      setState(() {
        if (deleteResponse) {
          userListingsList.removeAt(index);
        }
      });
      await AppBloc.homeCubit.onLoad(false);
    }
  }

  Future<void> _showOptionsDialog(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Text(Translate.of(context).translate('options'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                // Close the dialog and navigate to the edit screen
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.submit, arguments: {
                  'item': userListingsList[index],
                  'isNewList': false
                }).then((value) async {
                  final response = await context
                      .read<ProfileCubit>()
                      .loadUserListing(widget.user.id, 1);
                  setState(() {
                    userListingsList = response;
                  });
                });
              },
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: Text(Translate.of(context).translate('edit')),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                // Close the dialog and show the delete confirmation dialog
                Navigator.pop(context);
                showDeleteConfirmation(context, index);
              },
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: Text(Translate.of(context).translate('delete')),
              ),
            ),
          ],
        );
      },
    );
  }
}

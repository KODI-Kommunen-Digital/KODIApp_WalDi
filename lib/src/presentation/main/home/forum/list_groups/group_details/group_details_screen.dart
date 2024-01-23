import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/cubit/group_details_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/cubit/group_details_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsCubit, GroupDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const GroupDetailsLoading(),
        loaded: (posts, item, isAdmin, userId) =>
            GroupDetailsLoaded(posts, item, isAdmin, userId),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class GroupDetailsLoading extends StatelessWidget {
  const GroupDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GroupDetailsLoaded extends StatefulWidget {
  final List<GroupPostsModel> posts;
  final ForumGroupModel groupModel;
  final bool isAdmin;
  final int userId;

  const GroupDetailsLoaded(
      this.posts, this.groupModel, this.isAdmin, this.userId,
      {super.key});

  @override
  State<GroupDetailsLoaded> createState() => _GroupDetailsLoadedState();
}

class _GroupDetailsLoadedState extends State<GroupDetailsLoaded> {
  final memoryCacheManager = DefaultCacheManager();

  void _onAddPost() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.addPosts,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, Routes.addPosts,
            arguments: {'isNewPost': true, 'item': widget.groupModel})
        .then((value) async {
      await context.read<GroupDetailsCubit>().onLoad();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.imageZoom,
                    arguments:
                    (widget.groupModel.image != null)
                        ? "${Application.picturesURL}${widget.groupModel.image}?cacheKey=$uniqueKey"
                        : "${Application.picturesURL}admin/DefaultForum.jpeg?cacheKey=$uniqueKey",
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: widget.groupModel.image != null
                      ? "${Application.picturesURL}${widget.groupModel.image}?cacheKey=$uniqueKey"
                      : "${Application.picturesURL}admin/DefaultForum.jpeg?cacheKey=$uniqueKey",
                  cacheManager: memoryCacheManager,
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return AppPlaceholder(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.groupModel.forumName!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert, // Three vertical dots icon
                      ),
                      onSelected: (String choice) {
                        if (choice ==
                            Translate.of(context).translate('leave_group')) {
                          showLeaveGroupConfirmation(context);
                        } else if (choice ==
                            Translate.of(context).translate('see_member')) {
                          Navigator.pushNamed(
                            context,
                            Routes.groupMembersDetails,
                            arguments: {
                              'groupId': widget.groupModel.id,
                              'cityId': widget.groupModel.cityId
                            },
                          );
                        } else if (choice ==
                            Translate.of(context)
                                .translate('member_requests')) {
                          Navigator.pushNamed(
                              context, Routes.memberRequestDetails, arguments: {
                            'groupId': widget.groupModel.id,
                            'cityId': widget.groupModel.cityId
                          });
                        } else if (choice ==
                            Translate.of(context).translate('delete_group')) {
                          showDeleteGroupConfirmation(context);
                        } else if (choice ==
                            Translate.of(context).translate('edit_group')) {
                          Navigator.pushNamed(context, Routes.addGroups,
                              arguments: {
                                'isNewGroup': false,
                                'forumDetails': widget.groupModel
                              }).then((value) async {
                            await context.read<GroupDetailsCubit>().onLoad();
                            setState(() {});
                          });
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return widget.isAdmin
                            ? widget.groupModel.isPrivate == 1
                                ? {
                                    Translate.of(context)
                                        .translate('leave_group'),
                                    Translate.of(context)
                                        .translate('see_member'),
                                    Translate.of(context)
                                        .translate('edit_group'),
                                    Translate.of(context)
                                        .translate('member_requests'),
                                    Translate.of(context)
                                        .translate('delete_group'),
                                  }.map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList()
                                : {
                                    Translate.of(context)
                                        .translate('leave_group'),
                                    Translate.of(context)
                                        .translate('see_member'),
                                    Translate.of(context)
                                        .translate('edit_group'),
                                    Translate.of(context)
                                        .translate('delete_group'),
                                  }.map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList()
                            : {
                                Translate.of(context).translate('leave_group'),
                                Translate.of(context).translate('see_member'),
                              }.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                      },
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.groupModel.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextButton(
                      onPressed: () {
                        _onAddPost();
                      },
                      child: Text(
                        Translate.of(context).translate('add_post'),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.postDetails,
                            arguments: {
                              'item': widget.posts[index],
                              'cityId': widget.groupModel.cityId,
                              'userId': widget.userId,
                              'isAdmin': widget.isAdmin,
                            },
                          ).then((value) async {
                            await context.read<GroupDetailsCubit>().onLoad();
                            setState(() {});
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: widget.posts[index].image == null
                                  ? '${Application.picturesURL}admin/DefaultForum.jpeg'
                                  : "${Application.picturesURL}${widget.posts[index].image}?cacheKey=$uniqueKey",
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 84,
                                  height: 84,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) {
                                return AppPlaceholder(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    width: 84,
                                    height: 84,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return AppPlaceholder(
                                  child: Container(
                                    width: 84,
                                    height: 84,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: const Icon(Icons.error),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.posts[index].title ?? '',
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: widget.posts.length,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showLeaveGroupConfirmation(BuildContext buildContext) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(Translate.of(context).translate('group_leave_confirmation')),
          content: Text(Translate.of(context)
              .translate('Are_you_sure_you_want_to_leave_this_group')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await buildContext
                    .read<GroupDetailsCubit>()
                    .removeGroupMember(
                        widget.groupModel.id, widget.groupModel.cityId).then((isRemoved) {
                  if (isRemoved == RemoveUser.removed) {
                    if (!mounted) return;
                    Navigator.of(context).pop(true);
                  } else if (isRemoved == RemoveUser.onlyUser) {
                    if (!mounted) return;
                    Navigator.of(context).pop(false);
                    final popUpTitle =
                    Translate.of(context).translate('only_user');
                    final content =
                    Translate.of(context).translate('only_user_in_group');
                    showAdminPopup(context, popUpTitle, content);
                  } else if (isRemoved == RemoveUser.onlyAdmin) {
                    if (!mounted) return;
                    final popUpTitle =
                    Translate.of(context).translate('only_admin');
                    final content =
                    Translate.of(context).translate('add_another_admin');
                    Navigator.of(context).pop(false);
                    showAdminPopup(context, popUpTitle, content);
                  }
                });

              },
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
      Navigator.pop(context);
    }
  }

  Future<void> showDeleteGroupConfirmation(BuildContext buildContext) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              Translate.of(context).translate('group_delete_confirmation')),
          content: Text(Translate.of(context)
              .translate('are you sure you want to delete this group?')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await buildContext.read<GroupDetailsCubit>().requestDeleteGroup(
                    widget.groupModel.id, widget.groupModel.cityId);
                if (!mounted) return;
                Navigator.pop(context);
                Navigator.pop(context);
              },
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
    if (result == true) {}
  }

  void showAdminPopup(BuildContext context, title, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

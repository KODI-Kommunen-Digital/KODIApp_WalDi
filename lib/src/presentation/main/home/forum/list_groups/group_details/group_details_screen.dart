import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final ForumGroupModel item;

  const GroupDetailsScreen(this.item, {super.key});

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
        loaded: (posts) => GroupDetailsLoaded(posts, item),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class GroupDetailsLoading extends StatelessWidget {
  const GroupDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class GroupDetailsLoaded extends StatefulWidget {
  final List<GroupPostsModel> posts;
  final ForumGroupModel item;

  const GroupDetailsLoaded(this.posts, this.item, {super.key});

  @override
  State<GroupDetailsLoaded> createState() => _GroupDetailsLoadedState();
}

class _GroupDetailsLoadedState extends State<GroupDetailsLoaded> {
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
        arguments: {'isNewPost': true, 'item': widget.item});
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
                    arguments: "${Application.picturesURL}${widget.item.image}",
                  );
                },
                child: Image.network(
                  widget.item.image != null
                      ? "${Application.picturesURL}${widget.item.image}"
                      : "${Application.picturesURL}admin/News.jpeg",
                  fit: BoxFit.cover,
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
                        widget.item.forumName!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String choice) {
                        if (choice == 'Leave Group') {
                          showLeaveGroupConfirmation(context);
                        } else if (choice == 'See Members') {
                          Navigator.pushNamed(
                              context, Routes.groupMembersDetails,
                              arguments: widget.item.id);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Leave Group', 'See Members'}
                            .map((String choice) {
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
                    widget.item.description!,
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
                      child: const Text('Create post',
                          style: TextStyle(color: Colors.white)),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.postDetails,
                              arguments: widget.posts[index]);
                        },
                        child: Row(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: widget.posts[index].image == null
                                  ? '${Application.picturesURL}admin/News.jpeg'
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
          title: const Text('Group Leave Confirmation'),
          content: const Text('Are you sure you want to leave this group?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final isRemoved = await buildContext
                    .read<GroupDetailsCubit>()
                    .removeGroupMember(widget.item.id);
                if (isRemoved) {
                  if (!mounted) return;
                  Navigator.of(context).pop(true);
                }
                else{
                  ///Show that you are admin
                }
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
}

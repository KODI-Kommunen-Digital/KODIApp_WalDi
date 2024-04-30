// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/presentation/widget/app_forum_group_comments.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/presentation/widget/app_user_info.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

import 'cubit/post_detail_cubit.dart';
import 'cubit/post_detail_state.dart';

class PostDetailsScreen extends StatefulWidget {
  final GroupPostsModel item;

  const PostDetailsScreen(this.item, {super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostDetailCubit, PostDetailState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const PostDetailsLoading(),
        loaded: (userDetails, userImage, userId, isAdmin) => PostDetailsLoaded(
            userDetails, widget.item,
            userImage: userImage, userId: userId, isAdmin: isAdmin),
        orElse: () => ErrorWidget('Failed to load Post Details.'),
      ),
    );
  }
}

class PostDetailsLoading extends StatelessWidget {
  const PostDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class PostDetailsLoaded extends StatefulWidget {
  final GroupPostsModel post;
  final UserModel? userDetail;
  final String userImage;
  final int userId;
  final bool isAdmin;

  const PostDetailsLoaded(this.userDetail, this.post,
      {super.key,
      required this.userImage,
      required this.userId,
      required this.isAdmin});

  @override
  State<PostDetailsLoaded> createState() => _PostDetailsLoadedState();
}

class _PostDetailsLoadedState extends State<PostDetailsLoaded> {
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
                    Routes.forumImageZoom,
                    arguments: (widget.post.image != null)
                        ? "${Application.picturesURL}${widget.post.image}"
                        : "${Application.picturesURL}admin/DefaultForum.jpeg",
                  );
                },
                child: Image.network(
                  widget.post.image != null
                      ? "${Application.picturesURL}${widget.post.image}?cacheKey=$uniqueKey"
                      : "${Application.picturesURL}admin/DefaultForum.jpeg",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return AppPlaceholder(
                        child: Container(
                          width: 120,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Icon(Icons.error),
                        ),
                      );
                    }
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
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                      child: Text(
                        widget.post.title!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert, // Three vertical dots icon
                        ),
                        onSelected: (String choice) {
                          if (choice ==
                              Translate.of(context).translate('report_post')) {
                            showReportPostConfirmation(context);
                          } else if (choice ==
                              Translate.of(context).translate('delete_post')) {
                            showDeletePostConfirmation(context);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {
                            Translate.of(context).translate('report_post'),
                            if ((widget.post.userId == widget.userId) ||
                                widget.isAdmin)
                              Translate.of(context).translate('delete_post'),
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    widget.post.createdAt!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.post.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).dividerColor.withOpacity(
                              .05,
                            ),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(
                          0,
                          2,
                        ),
                      ),
                    ],
                  ),
                  child: AppUserInfo(
                    user: widget.userDetail,
                    onPressed: () async {
                      final loggedInUserId = await context
                          .read<PostDetailCubit>()
                          .getLoggedInUserId();
                      if (!mounted) return;

                      if (widget.post.userId == loggedInUserId) {
                        if (!mounted) return;
                        Navigator.pushNamed(context, Routes.profile,
                            arguments: {
                              'user': widget.userDetail,
                              'editable': true
                            });
                      } else {
                        if (!mounted) return;
                        Navigator.pushNamed(context, Routes.profile,
                            arguments: {
                              'user': widget.userDetail,
                              'editable': false
                            });
                      }
                    },
                    type: UserViewType.information,
                    showDirectionIcon: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final postDetailCubit = context.read<PostDetailCubit>();
          List<CommentModel> comments = await context
              .read<PostDetailCubit>()
              .getPostComments(widget.post.forumId, widget.post.id, 1);
          if (!mounted) return;
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CommentsBottomSheet(
                  forumId: widget.post.forumId,
                  postId: widget.post.id,
                  comments: comments,
                  postDetailCubit: postDetailCubit,
                  userProfileImage: widget.userDetail?.image,
                  userImage: widget.userImage);
            },
          );
        },
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showReportPostConfirmation(BuildContext buildContext) async {
    String reportReason = '';

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(Translate.of(context).translate('post_report_confirmation')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: double.maxFinite,
                child: TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    reportReason = value;
                  },
                  decoration: InputDecoration(
                    hintText:
                        Translate.of(context).translate('report_post_hint'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final isReported =
                    await buildContext.read<PostDetailCubit>().reportGroupPosts(
                          widget.post.forumId,
                          widget.post.id,
                          reportReason,
                        );
                if (isReported) {
                  if (!mounted) return;
                  Navigator.of(context).pop(true);
                } else {
                  // Handle the case where the post could not be reported
                  // Show an error message or take appropriate action
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
      // Navigator.pop(context);
    }
  }

  Future<void> showDeletePostConfirmation(BuildContext buildContext) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(Translate.of(context).translate('post_delete_confirmation')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.maxFinite,
                child: Text(Translate.of(context)
                    .translate('post_delete_confirmation_body')),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final isDeleted =
                    await buildContext.read<PostDetailCubit>().deleteGroupPost(
                          widget.post.forumId,
                          widget.post.id,
                        );
                if (isDeleted) {
                  if (!mounted) return;
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                } else {
                  // Handle the case where the post could not be reported
                  // Show an error message or take appropriate action
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
      // Navigator.pop(context);
    }
  }
}

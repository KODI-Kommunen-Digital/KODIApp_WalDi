import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_comment.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';

class CommentReplyWidget extends StatefulWidget {
  final CommentModel comment;
  final PostDetailCubit postDetailCubit;

  const CommentReplyWidget({
    Key? key,
    required this.comment,
    required this.postDetailCubit,
  }) : super(key: key);

  @override
  CommentReplyWidgetState createState() => CommentReplyWidgetState();
}

class CommentReplyWidgetState extends State<CommentReplyWidget> {
  List<CommentModel>? replies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 40),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              (widget.comment.userProfileImage == 'Keine Angabe' ||
                      widget.comment.userProfileImage == "")
                  ? Application.defaultPicturesURL
                  : "${Application.picturesURL}${widget.comment.userProfileImage}",
            ),
            radius: 20,
          ),
          title: Text(
            widget.comment.username!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          subtitle: Text(
            widget.comment.comment!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        if (replies != null)
          Column(
            children: [
              for (final reply in replies!)
                Column(
                  children: [
                    const Divider(
                      height: 8,
                      thickness: 4,
                    ),
                    CommentReplyWidget(
                      comment: reply,
                      postDetailCubit: widget.postDetailCubit,
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

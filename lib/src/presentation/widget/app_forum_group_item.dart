// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/widget/empty_product_item.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class ForumGroupItem extends StatefulWidget {
  const ForumGroupItem(
      {Key? key,
      this.item,
      required this.userId,
      required this.onPressed,
      required this.fromGroupList})
      : super(key: key);

  final ForumGroupModel? item;
  final void Function(bool) onPressed;
  final int userId;
  final bool fromGroupList;

  @override
  State<ForumGroupItem> createState() => _ForumGroupItemState();
}

class _ForumGroupItemState extends State<ForumGroupItem> {
  bool isJoined = false;
  bool isRequested = false;
  String groupStatus = '';

  @override
  void initState() {
    super.initState();
    isJoined = widget.item!.isJoined!;
    isRequested = widget.item!.isRequested!;
    groupStatus = widget.item?.isRequested == true
        ? 'Anfrage verschickt'
        : widget.item?.isJoined == false
            ? 'Beitreten'
            : 'zur Gruppe';
  }

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();

    if (widget.item == null) {
      return const EmptyProductItem();
    }

    return InkWell(
      onTap: () {
        return widget.userId != 0
            ? isRequested || isJoined == false
                ? null
                : widget.onPressed(true)
            : widget.onPressed(false);
      },
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.item?.image == 'admin/DefaultForum.jpeg'
                    ? "${Application.picturesURL}${widget.item?.image}"
                    : "${Application.picturesURL}${widget.item!.image}?cacheKey=$uniqueKey",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(11),
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
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.network(
                    '${Application.picturesURL}admin/DefaultForum.jpeg',
                    width: 120,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle errors here
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        width: 120,
                        height: 140,
                        child: const Icon(Icons.error),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      // Display the AppPlaceholder while the image is loading
                      if (loadingProgress == null) {
                        return child;
                      }
                      return AppPlaceholder(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          width: 120,
                          height: 140,
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.item?.forumName ?? '',
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        widget.item?.isPrivate == 0
                            ? Translate.of(context).translate('public')
                            : Translate.of(context).translate('private'),
                        maxLines: 2,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (widget.userId != 0)
                      InkWell(
                        onTap: () {
                          if (isRequested == false) {
                            if (isJoined == false) {
                              showJoinGroupDialog(context, widget.item?.id);
                            } else {
                              Navigator.pushNamed(context, Routes.groupDetails,
                                      arguments: widget.item)
                                  .then((value) async {
                                if (widget.fromGroupList) {
                                  await context
                                      .read<ListGroupsCubit>()
                                      .onLoad();
                                } else {
                                  await context.read<MyGroupsCubit>().onLoad();
                                }
                              });
                              // widget.onPressed;
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            groupStatus,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    const Row(
                      children: <Widget>[
                        SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showJoinGroupDialog(BuildContext context, int? id) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('request_Confirmation')),
          content: Text(Translate.of(context)
              .translate('Do_you_want_to_join_this_group?')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                // await AppBloc.homeCubit.onLoad(false);
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
      final joinRequestResponse =
          await context.read<ListGroupsCubit>().requestToJoinGroup(id);
      if (joinRequestResponse == 'Member added successfully') {
        setState(() {
          groupStatus = 'zur Gruppe';
          isJoined = true;
          isRequested = false;
        });
      } else if (joinRequestResponse == 'Request sent successfully') {
        setState(() {
          groupStatus = 'Anfrage verschickt';
          isJoined = true;
          isRequested = true;
        });
      } else {
        setState(() {
          isRequested = false;
          isJoined = false;
        });
      }

      // if (!mounted) return;
      // final deleteResponse = await context.read<ProfileCubit>().deleteUserList(
      //   userListingsList[index].cityId.toString(),
      //   userListingsList[index].id,
      // );
      // setState(() {
      //   if (deleteResponse) {
      //     userListingsList.removeAt(index);
      //   }
      // });
      // }
    }
  }
}

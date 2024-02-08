import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:intl/intl.dart';

class GroupMembersScreen extends StatefulWidget {
  final int groupId;

  const GroupMembersScreen(this.groupId, {super.key});

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupMembersCubit, GroupMembersState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const GroupMembersLoading(),
        loaded: (membersList, isAdmin) => GroupMembersLoaded(
          isAdmin: isAdmin,
          membersList: membersList,
          forumId: widget.groupId,
        ),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class GroupMembersLoading extends StatelessWidget {
  const GroupMembersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class GroupMembersLoaded extends StatefulWidget {
  final List<GroupMembersModel>? membersList;
  final bool isAdmin;
  final int forumId;

  const GroupMembersLoaded(
      {this.membersList,
      super.key,
      required this.isAdmin,
      required this.forumId});

  @override
  State<GroupMembersLoaded> createState() => _GroupMembersLoadedState();
}

class _GroupMembersLoadedState extends State<GroupMembersLoaded> {
  final memoryCacheManager = DefaultCacheManager();
  int loggedUserId = 0;
  bool isMemberAdmin = false;

  @override
  void initState() {
    // isAdmin = widget.isAdmin;
    super.initState();
  }

  void loggedInUserId() async {
    loggedUserId = await context.read<GroupMembersCubit>().getLoggedInUserId();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy.MM.dd');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('members'),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 8),
          itemCount: widget.membersList?.length,
          itemBuilder: (context, index) {
            isMemberAdmin =
                widget.membersList?[index].isAdmin == 1 ? true : false;
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.membersList?[index].image != null
                              ? '${Application.picturesURL}${widget.membersList?[index].image}'
                              : '${Application.picturesURL}admin/DefaultForum.jpeg',
                          cacheManager: memoryCacheManager,
                          placeholder: (context, url) {
                            return AppPlaceholder(
                              child: Container(
                                height: 100,
                                width: 100,
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
                                height: 100,
                                width: 100,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                '${widget.membersList?[index].firstname} ${widget.membersList?[index].lastname}',
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                isMemberAdmin
                                    ? ' [Admin]'
                                    : ' [${Translate.of(context).translate('member')}] ',
                                maxLines: 1,
                                style: TextStyle(
                                    color: isMemberAdmin
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                          // description,
                          const SizedBox(height: 4),
                          Text(
                            (dateFormat.format(DateTime.parse(
                                    widget.membersList![index].joinedAt!)))
                                .toString(),
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.isAdmin,
                      child: isMemberAdmin
                          ? PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert, // Three vertical dots icon
                              ),
                              onSelected: (String choice) async {
                                if (choice ==
                                    Translate.of(context)
                                        .translate('remove_admin')) {
                                  final response = await context
                                      .read<GroupMembersCubit>()
                                      .requestRemoveAdmin(widget.forumId,
                                          widget.membersList?[index].memberId);
                                  if (response) {
                                    if (!mounted) return;
                                    context.read<GroupMembersCubit>().onLoad();
                                  } else {
                                    if (!mounted) return;
                                    showOnlyAdminPopup(context);
                                  }
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return {
                                  Translate.of(context)
                                      .translate('remove_admin')
                                }.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            )
                          : PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert, // Three vertical dots icon
                              ),
                              onSelected: (String choice) async {
                                if (choice ==
                                    Translate.of(context)
                                        .translate('make_admin')) {
                                  await context
                                      .read<GroupMembersCubit>()
                                      .requestMakeUserAdmin(widget.forumId,
                                          widget.membersList?[index].memberId);
                                  if (!mounted) return;
                                  context.read<GroupMembersCubit>().onLoad();
                                } else if (choice ==
                                    Translate.of(context)
                                        .translate('remove_admin')) {
                                  await context
                                      .read<GroupMembersCubit>()
                                      .requestRemoveAdmin(widget.forumId,
                                          widget.membersList?[index].memberId);
                                  if (!mounted) return;
                                  context.read<GroupMembersCubit>().onLoad();
                                } else if (choice ==
                                    Translate.of(context)
                                        .translate('remove_member')) {
                                  await context
                                      .read<GroupMembersCubit>()
                                      .removeUserFromGroup(widget.forumId,
                                          widget.membersList?[index].memberId);
                                  if (!mounted) return;
                                  context.read<GroupMembersCubit>().onLoad();
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return {
                                  !isMemberAdmin
                                      ? Translate.of(context)
                                          .translate('make_admin')
                                      : Translate.of(context)
                                          .translate('remove_admin'),
                                  Translate.of(context)
                                      .translate('remove_member')
                                }.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                      // IconButton(
                      //   icon: const Icon(Icons.more_vert),
                      //   onPressed: () {
                      //
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showOnlyAdminPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('only_admin')),
          content: Text(Translate.of(context).translate('add_another_admin')),
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

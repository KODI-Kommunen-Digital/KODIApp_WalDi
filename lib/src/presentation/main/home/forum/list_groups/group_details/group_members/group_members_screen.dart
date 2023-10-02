import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_group_members.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_state.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

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
  int loggedUserId = 0;
  bool isUserAdmin = false;

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
            isUserAdmin =
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
                          child: Image.network(
                        widget.membersList?[index].image != null
                            ? '${Application.picturesURL}${widget.membersList?[index].image}'
                            : '${Application.picturesURL}admin/News.jpeg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
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
                                isUserAdmin ? ' [Admin]' : ' [Member]',
                                maxLines: 1,
                                style: TextStyle(
                                    color: isUserAdmin
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                          // description,
                          const SizedBox(height: 4),
                          Text(
                            '${widget.membersList?[index].joinedAt}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.isAdmin,
                      child: PopupMenuButton<String>(
                        onSelected: (String choice) async {
                          if (choice ==
                              Translate.of(context).translate('make_admin')) {
                            await context
                                .read<GroupMembersCubit>()
                                .requestMakeUserAdmin(widget.forumId,
                                    widget.membersList?[index].memberId);
                            if (!mounted) return;
                            context.read<GroupMembersCubit>().onLoad();
                          } else if (choice ==
                              Translate.of(context).translate('remove_admin')) {
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
                            !isUserAdmin
                                ? Translate.of(context).translate('make_admin')
                                : Translate.of(context)
                                    .translate('remove_admin'),
                            Translate.of(context).translate('remove_member')
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
}

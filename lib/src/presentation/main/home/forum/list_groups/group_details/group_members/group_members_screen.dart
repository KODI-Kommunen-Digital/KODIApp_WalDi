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
        loaded: (membersList) => GroupMembersLoaded(
          membersList: membersList,
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
    return const Placeholder();
  }
}

class GroupMembersLoaded extends StatefulWidget {
  final List<GroupMembersModel>? membersList;

  const GroupMembersLoaded({this.membersList, super.key});

  @override
  State<GroupMembersLoaded> createState() => _GroupMembersLoadedState();
}

class _GroupMembersLoadedState extends State<GroupMembersLoaded> {
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
                          Text(
                            '${widget.membersList?[index].firstname} ${widget.membersList?[index].lastname}',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
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
                    IconButton(
                      icon: const Icon(Icons.more_vert), // Three dots icon
                      onPressed: () {},
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

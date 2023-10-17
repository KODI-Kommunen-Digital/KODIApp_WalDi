import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_member_request.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_state.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class MemberRequestScreen extends StatefulWidget {
  final int groupId;

  const MemberRequestScreen(this.groupId, {super.key});

  @override
  State<MemberRequestScreen> createState() => _MemberRequestScreenState();
}

class _MemberRequestScreenState extends State<MemberRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembersRequestsCubit, MemberRequestState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const MemberRequestLoading(),
        loaded: (membersList) => MemberRequestLoaded(
          membersList: membersList,
          forumId: widget.groupId,
        ),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class MemberRequestLoading extends StatelessWidget {
  const MemberRequestLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class MemberRequestLoaded extends StatefulWidget {
  final List<MemberRequestModel>? membersList;
  final int forumId;

  const MemberRequestLoaded(
      {this.membersList, super.key, required this.forumId});

  @override
  State<MemberRequestLoaded> createState() => _MemberRequestLoadedState();
}

class _MemberRequestLoadedState extends State<MemberRequestLoaded> {
  int loggedUserId = 0;
  bool isMemberAdmin = false;

  @override
  void initState() {
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
                        ),
                      ),
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
                            '${widget.membersList?[index].createdAt}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    // Add tick and cross buttons here
                    Row(
                      children: [
                        InkWell(
                          onTap: () async{
                            await context
                                .read<MembersRequestsCubit>()
                                .acceptMemberRequests(
                                    widget.membersList?[index].requestId);
                            if(!mounted) return;
                            await context
                                .read<MembersRequestsCubit>().onLoad();
                            setState(() {

                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            await context
                                .read<MembersRequestsCubit>()
                                .rejectMemberRequests(
                                widget.membersList?[index].requestId, 'reject request');
                            if(!mounted) return;
                            await context
                                .read<MembersRequestsCubit>().onLoad();
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
          title: const Text('You Are the Only Admin'),
          content: const Text(
              'You cannot remove yourself as a common member as you are the only admin. First, make someone else an admin before becoming just a member'),
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

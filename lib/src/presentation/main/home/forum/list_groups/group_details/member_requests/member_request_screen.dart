import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_member_request.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:intl/intl.dart';

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
  final memoryCacheManager = DefaultCacheManager();
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
  Widget build(BuildContext buildContext) {
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
                              : '${Application.picturesURL}admin/News.jpeg',
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
                          Text(
                            '${widget.membersList?[index].firstname} ${widget.membersList?[index].lastname}',
                            maxLines: 1,
                            style: Theme.of(buildContext).textTheme.titleSmall,
                          ),
                          // description,
                          const SizedBox(height: 4),
                          Text(
                            (dateFormat.format(DateTime.parse(
                                    widget.membersList![index].createdAt!)))
                                .toString(),
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
                          onTap: () async {
                            showAcceptRequestConfirmation(buildContext, index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 14),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            showIgnoreRequestConfirmation(buildContext, index);
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
                              size: 35,
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

  Future<void> showIgnoreRequestConfirmation(
      BuildContext buildContext, index) async {
    String reason = '';

    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context)
              .translate('ignore_member_request_confirmation')),
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
                    reason = value;
                  },
                  decoration: InputDecoration(
                    hintText: Translate.of(context).translate('give_reason'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final response = await buildContext
                    .read<MembersRequestsCubit>()
                    .rejectMemberRequests(
                        widget.membersList?[index].requestId, reason);
                if (!mounted) return;
                await buildContext.read<MembersRequestsCubit>().onLoad();
                setState(() {});
                if (response) {
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

  Future<void> showAcceptRequestConfirmation(
      BuildContext buildContext, index) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context)
              .translate('accept_request_confirmation_message')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.maxFinite,
                child: Text(Translate.of(context)
                    .translate("accept_request_confirmation")),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final response = await buildContext
                    .read<MembersRequestsCubit>()
                    .acceptMemberRequests(widget.membersList?[index].requestId);
                if (!mounted) return;
                await buildContext.read<MembersRequestsCubit>().onLoad();
                setState(() {});
                if (response) {
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
              onPressed: () => Navigator.of(context).pop(false),
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

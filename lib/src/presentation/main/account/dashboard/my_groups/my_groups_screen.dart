import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/widget/app_forum_group_item.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

import 'cubit/my_groups_state.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({Key? key}) : super(key: key);

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  GroupFilter? selectedFilter;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('my_groups'),
          ),
        ),
        body: BlocConsumer<MyGroupsCubit, MyGroupsState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (msg) =>
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(msg))),
              orElse: () {},
            );
          },
          builder: (context, state) =>
              state.when(
                loading: () => const ListLoading(),
                loaded: (list, userId) =>
                    ListLoaded(
                      list: list,
                      userId: userId,
                    ),
                updated: (list, userId) {
                  return ListLoaded(
                    list: list,
                    userId: userId,
                  );
                },
                error: (e) => ErrorWidget('Failed to load listings.'),
                initial: () {
                  return Container();
                },
              ),
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class ListLoaded extends StatefulWidget {
  final List<ForumGroupModel> list;
  final int userId;

  const ListLoaded({
    Key? key,
    required this.list,
    required this.userId,
  }) : super(key: key);

  @override
  State<ListLoaded> createState() => _ListLoadedState();
}

class _ListLoadedState extends State<ListLoaded> {
  bool isLoading = false;
  bool isLoadingMore = false;
  final ProductViewType _listMode = Application.setting.listMode;
  double previousScrollPosition = 0;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: widget.list.isNotEmpty
              ? SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          final item = widget.list[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildItem(item: item, type: _listMode),
                          );
                        },
                        childCount: widget.list.length,
                      ),
                    ),
                  ],
                ),
                if (isLoadingMore)
                  const Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
              ],
            ),
          )
              : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItem({
    ForumGroupModel? item,
    required ProductViewType type,
  }) {
    if (item != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ForumGroupItem(
          userId: widget.userId,
          onPressed: (value) async {
            if (value) {
              Navigator.pushNamed(context, Routes.groupDetails, arguments: item)
                  .then((value) async {
                await context.read<MyGroupsCubit>().onLoad();
                setState(() {});
              });
            } else {
              final popUpResult = await _showLoginPopup(context);
              if (popUpResult == true) {
                if (!mounted) return;

                await Navigator.pushNamed(
                  context,
                  Routes.signIn,
                  arguments: Routes.submit,
                ).then((value) async {
                  await context.read<MyGroupsCubit>().onLoad();
                  setState(() {});
                });
              }
            }
          },
          item: item,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppProductItem(
        isRefreshLoader: true,
        type: _listMode,
      ),
    );
  }

  Future<dynamic> _showLoginPopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('login_required')),
          content: Text(Translate.of(context)
              .translate('Please_log_in_to_enter_any_group.')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: Text(Translate.of(context).translate('login')),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Text(Translate.of(context).translate('cancel')),
            ),
          ],
        );
      },
    );
  }
}

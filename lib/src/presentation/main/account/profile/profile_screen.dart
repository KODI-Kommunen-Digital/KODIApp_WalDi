import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_cubit.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_state.dart';
import 'package:heidi/src/presentation/widget/app_user_info.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  final bool isEditable;

  const ProfileScreen({required this.user, required this.isEditable, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const ProfileLoading(),
        loaded: (userListing) => ProfileLoaded(user, userListing, isEditable),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ProfileLoaded extends StatefulWidget {
  final UserModel user;
  final List<ProductModel> userListings;
  final bool isEditable;

  const ProfileLoaded(this.user, this.userListings, this.isEditable, {Key? key})
      : super(key: key);

  @override
  State<ProfileLoaded> createState() => _ProfileLoadedState();
}

class _ProfileLoadedState extends State<ProfileLoaded> {
  bool isLoading = false;
  bool isSwiped = false;
  List<ProductModel> userListingsList = [];

  @override
  void initState() {
    super.initState();
    userListingsList.addAll(widget.userListings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('profile'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
              children: [
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
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: AppUserInfo(
                    user: widget.user,
                    type: UserViewType.information,
                    showDirectionIcon: false,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    Translate.of(context).translate('my_listings'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(children: [
                  Center(
                    child: Visibility(
                      visible: isLoading,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  userListingsList == []
                      ? Container()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: userListingsList.length,
                          itemBuilder: (context, index) {
                            final item = userListingsList[index];
                            return Slidable(
                              endActionPane: !widget.isEditable ? null :ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (aContext) {
                                      Navigator.pushNamed(
                                          context, Routes.submit, arguments: {
                                        'item': userListingsList[index],
                                        'isNewList': false
                                      }).then((value) async {
                                        final response = await context
                                            .read<ProfileCubit>()
                                            .loadUserListing();
                                        setState(() {
                                          userListingsList = response;
                                        });
                                      });
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label:
                                        Translate.of(context).translate('edit'),
                                  ),
                                  SlidableAction(
                                    onPressed: (aContext) async {
                                      showDeleteConfirmation(context, index);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: Translate.of(context)
                                        .translate('delete'),
                                  ),
                                ],
                              ),
                              key:
                                  Key(item.id.toString() + isSwiped.toString()),
                              child: InkWell(
                                onTap: () {
                                  _onProductDetail(item);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 120,
                                              height: 140,
                                              child: Image.network(
                                                "${Application.picturesURL}${item.image}",
                                                width: 120,
                                                //       height: 140,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    userListingsList[index]
                                                            .category ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    userListingsList[index]
                                                        .title,
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    userListingsList[index]
                                                                .categoryId ==
                                                            3
                                                        ? "${userListingsList[index].startDate} ${Translate.of(context).translate('to')} ${userListingsList[index].endDate}"
                                                        : userListingsList[
                                                                index]
                                                            .createDate,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const SizedBox(height: 8),
                                                  const SizedBox(height: 4),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  Future<void> showDeleteConfirmation(BuildContext context, int index) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(Translate.of(context)
              .translate('Are_you_sure_you_want_to_delete_this_item?')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Yes
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
      final deleteResponse = await context.read<ProfileCubit>().deleteUserList(
            userListingsList[index].cityId.toString(),
            userListingsList[index].id,
          );
      logError('deleteResponse', deleteResponse);
      setState(() {
        if (deleteResponse) {
          userListingsList.removeAt(index);
        }
      });
    }
  }

  Future<void> _onRefresh() async {
    context.read<ProfileCubit>().loadUserListing();
  }
}

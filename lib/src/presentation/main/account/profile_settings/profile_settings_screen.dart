// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/account_profile/cubit/account_cubit.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('setting'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            AppListTitle(
              title: Translate.of(context).translate(
                'edit_profile',
              ),
              trailing: RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.editProfile).then((value) {
                  setState(() {});
                });
              },
            ),
            AppListTitle(
              title: Translate.of(context).translate(
                'change_password',
              ),
              trailing: RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              ),
              onPressed: () {
                _onNavigate(Routes.changePassword);
              },
            ),
            AppListTitle(
              title: Translate.of(context).translate('delete_Account'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        Translate.of(context).translate('delete_Account'),
                      ),
                      content: Text(
                        Translate.of(context)
                            .translate('delete_Account_Confirmation'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            Translate.of(context).translate('yes'),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final isDeleted = await context
                                .read<AccountCubit>()
                                .deleteUserAccount();
                            if (isDeleted) {
                              _showSuccessSnackBar();
                              AppBloc.loginCubit.onLogout();
                              await Navigator.pushNamed(
                                context,
                                Routes.signIn,
                                arguments: Routes.submit,
                              );
                            } else {
                              _showErrorSnackBar();
                            }
                          },
                        ),
                        TextButton(
                          child: Text(
                            Translate.of(context).translate('no'),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              trailing: RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(Translate.of(context).translate("delete_account_success"))));
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate("delete_account_fail"))));
  }
}

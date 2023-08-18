import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/cubit/user/cubit.dart';
import 'package:heidi/src/presentation/main/account/account_profile/cubit/account_cubit.dart';
import 'package:heidi/src/presentation/main/account/account_profile/cubit/account_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/presentation/widget/app_user_info.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/translate.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(msg))),
          orElse: () {},
        );
      },
      builder: (context, state) => state.maybeWhen(
        loading: () => const AccountLoading(),
        loaded: () => const AccountLoaded(),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PaintingBinding.instance.imageCache.clear();
  }
}

class AccountLoading extends StatelessWidget {
  const AccountLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class AccountLoaded extends StatefulWidget {
  const AccountLoaded({Key? key}) : super(key: key);

  @override
  State<AccountLoaded> createState() => _AccountLoadedState();
}

class _AccountLoadedState extends State<AccountLoaded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('my_account'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('sign_out'),
            mainAxisSize: MainAxisSize.max,
            onPressed: _onLogout,
            type: ButtonType.text,
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserModel?>(
          builder: (context, user) {
            if (user == null) {
              UtilLogger.log('Null User');
            }
            return SingleChildScrollView(
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
                      user: user,
                      type: UserViewType.information,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.profile,
                            arguments: {'user': user, 'editable': true});                      },
                      showDirectionIcon: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
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
                          Navigator.pushNamed(context, Routes.editProfile)
                              .then((value) {
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
                        title: Translate.of(context).translate('setting'),
                        onPressed: () {
                          _onNavigate(Routes.setting);
                        },
                        trailing: RotatedBox(
                          quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),
                      AppListTitle(
                        title: Translate.of(context).translate('contact'),
                        onPressed: () {
                          _onNavigate(Routes.contactUs);
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
                  const SizedBox(height: 4),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogout() async {
    AppBloc.loginCubit.onLogout();
  }

  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/configs/theme.dart';
import 'package:heidi/src/utils/translate.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, this.user}) : super(key: key);

  final UserModel? user;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _receiveNotification = true;
  bool darkModeEnabled = true;

  Future<void> switchTheme() async {
    final prefBox = await Preferences.openBox();

    DarkOption darkOption =
    darkModeEnabled ? DarkOption.alwaysOn : DarkOption.alwaysOff;
    String darkOptionValue = darkModeEnabled ? 'on' : 'off';

    await prefBox.setKeyValue(Preferences.darkOption, darkOptionValue);
    AppBloc.themeCubit.onChangeTheme(darkOption: darkOption);
  }

  Future<void> isDarkMode() async {
    final prefBox = await Preferences.openBox();
    String darkMode = await prefBox.getKeyValue(Preferences.darkOption, 'on');
    setState(() {
      darkModeEnabled = (darkMode == 'on');
    });
  }

  @override
  void initState() {
    super.initState();
    isDarkMode();
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
              title: Translate.of(context).translate('notification'),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: _receiveNotification,
                onChanged: (value) {
                  setState(() {
                    _receiveNotification = value;
                  });
                },
              ),
            ),
            AppListTitle(
              title: "Dark Mode",
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    darkModeEnabled = value;
                    switchTheme();
                  });
                },
              ),
            ),
            if(widget.user != null)
            AppListTitle(
              title: Translate.of(context).translate('profile_settings'),
              onPressed: () {
                _onNavigate(Routes.profileSettings);
              },
              trailing: Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            AppListTitle(
              title: Translate.of(context).translate('legal'),
              onPressed: () {
                _onNavigate(Routes.legal);
              },
              trailing: Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

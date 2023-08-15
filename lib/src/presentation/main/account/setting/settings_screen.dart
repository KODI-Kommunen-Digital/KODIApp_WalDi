import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _receiveNotification = true;

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

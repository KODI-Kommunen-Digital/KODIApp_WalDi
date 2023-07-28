import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _makeAction(String link) async {
    if (await canLaunchUrl(
      Uri.parse(link),
    )) {
      await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.inAppWebView,
      );
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('legal'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            AppListTitle(
              title: Translate.of(context).translate('imprint'),
              onPressed: () {
                _makeAction('https://ilzerland.bayern/impressum/');
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
              title: Translate.of(context).translate('privacy_policy'),
              onPressed: () {
                _makeAction('https://ilzerland.bayern/datenschutz/');
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

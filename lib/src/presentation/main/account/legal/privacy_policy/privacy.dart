import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_privacy.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/translate.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  PrivacyPageModel? _privacyPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildWhoWeAre() {
    if (_privacyPage?.whoWeAre == null) {
      return AppPlaceholder(
          child: Column(
        children: [1, 2, 3, 4, 5].map((item) {
          return Container(
            height: 10,
            margin: const EdgeInsets.only(bottom: 4),
            color: Colors.white,
          );
        }).toList(),
      ));
    }

    return Text(
      _privacyPage!.whoWeAre,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('privacy_policy'),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 4),
                        _buildWhoWeAre(),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

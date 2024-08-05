import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_imprint.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/translate.dart';

class ImprintScreen extends StatefulWidget {
  const ImprintScreen({super.key});

  @override
  State<ImprintScreen> createState() => _ImprintScreenState();
}

class _ImprintScreenState extends State<ImprintScreen> {
  ImprintPageModel? _imprintPage;

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget imprintDetails() {
    if (_imprintPage?.whoWeAre == null) {
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
      _imprintPage!.whoWeAre,
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
              Translate.of(context).translate('imprint'),
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
                        imprintDetails(),
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

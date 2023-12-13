import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_faq.dart';
import 'package:heidi/src/presentation/main/account/faq/cubit/faq_cubit.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  Future<List<dynamic>>? _faqDataFuture;

  @override
  void initState() {
    super.initState();
    _faqDataFuture = _fetchFaqData();
  }

  Future<List<dynamic>> _fetchFaqData() async {
    final faqData = await context.read<FaqCubit>().fetchFaqData();
    return faqData;
  }

  void _onItemPressed(FaqModel item) {
    _openInAppBrowser(item.link, item.isPdf);
  }

  Future<void> _openInAppBrowser(String link, bool? isPdf) async {
    if (isPdf!) {
      link = "${Application.picturesURL}$link";
    } else {
      if (!link.startsWith("https://") && !link.startsWith("http://")) {
        link = "https://$link";
      }
    }

    await launchUrl(Uri.parse(link), mode: LaunchMode.inAppWebView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('faq')),
      ),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: _faqDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final faqData = snapshot.data!;
              return ListView.builder(
                itemCount: faqData.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = faqData[index];
                  return AppListTitle(
                    title: item.title,
                    onPressed: () {
                      _onItemPressed(item);
                    },
                    trailing: RotatedBox(
                      quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

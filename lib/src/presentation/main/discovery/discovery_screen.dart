// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      // Images.service1,
      Images.service2,
      Images.service3,
      Images.service4,
      Images.service5,
      Images.service6,
      Images.service7,
      Images.service8,
      Images.service9,
      // Add more image URLs as needed
    ];

    final List<String> imageLinks = [
      // '1',
      '2',
      'error',
      '4',
      '5',
      '6',
      '7',
      'error',
      '9',
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('cust_services')),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as desired
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 300.0),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              navigateToLink(imageLinks[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> navigateToLink(String link) async {
    final prefs = await Preferences.openBox();
    if (link == "1") {
      await launchUrl(Uri.parse('https://mitreden.ilzerland.bayern/ringelai'),
          mode: LaunchMode.inAppWebView
          // enableJavaScript: true, // Enable JavaScript in the in-app browser
          );
    } else if (link == "2") {
      await launchUrl(
          Uri.parse(await AppBloc.discoveryCubit.getCityLink() ?? ""),
          mode: LaunchMode.inAppWebView);
    } else if (link == "error") {
      _onPopUpError();
    } else if (link == "4") {
      prefs.setKeyValue(Preferences.categoryId, 1);
      prefs.setKeyValue(Preferences.type, "categoryService");
      Navigator.pushNamed(context, Routes.listProduct, arguments: 4);
    } else if (link == "5") {
      prefs.setKeyValue(Preferences.categoryId, 3);
      prefs.setKeyValue(Preferences.type, "categoryService");
      Navigator.pushNamed(context, Routes.listProduct, arguments: 5);
    } else if (link == "6") {
      prefs.setKeyValue(Preferences.categoryId, 4);
      prefs.setKeyValue(Preferences.type, "categoryService");
      Navigator.pushNamed(context, Routes.listProduct, arguments: 6);
    } else if (link == "7") {
      prefs.setKeyValue(Preferences.categoryId, 10);
      prefs.setKeyValue(Preferences.type, "categoryService");
      Navigator.pushNamed(context, Routes.listProduct, arguments: 7);
    } else if (link == "9") {
      prefs.setKeyValue(Preferences.categoryId, 6);
      prefs.setKeyValue(Preferences.type, "categoryService");
      Navigator.pushNamed(context, Routes.listProduct, arguments: 9);
    }
  }

  void _onPopUpError() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(Translate.of(context).translate('functionNotAvail')),
        content: Text(Translate.of(context).translate('functionNotAvailBody')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

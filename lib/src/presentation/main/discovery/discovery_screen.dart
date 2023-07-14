import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';
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
      Images.service1,
      Images.service2,
      Images.service3,
      Images.service4,
      Images.service5,
      Images.service6,
      Images.service7,
      Images.service8,
      Images.service9,
      Images.service10,
      // Add more image URLs as needed
    ];

    final List<String> imageLinks = [
      'error',
      'error',
      'error',
      'https://vgem-fuchstal.de/vg-fuchstal/was-erledige-ich-wo/#online-antraege',
      'error',
      'error',
      'error',
      'error',
      'error',
      'error',
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
    if (link == "error") {
      _onPopUpError();
    } else if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.inAppWebView,
      );
    } else {
      throw 'Could not launch $link';
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

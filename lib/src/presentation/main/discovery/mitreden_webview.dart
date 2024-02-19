import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MitredenWebview extends StatefulWidget {
  final String link;

  const MitredenWebview({super.key, required this.link});

  @override
  State<MitredenWebview> createState() => _MitredenWebviewState();
}

class _MitredenWebviewState extends State<MitredenWebview> {
  bool isLoading = true;

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Stack(
            children: [
              InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              if (progress == 100) {
               
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          Center(
              child: (isLoading)
                  ? Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.loading,
                              width: 250,
                              height: 250,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              Translate.of(context).translate('loading'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container())
        ]),
      ),
    );
  }
}

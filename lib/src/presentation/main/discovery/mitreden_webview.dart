import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MitredenWebview extends StatefulWidget {
  final String link;

  const MitredenWebview({super.key, required this.link});

  @override
  State<MitredenWebview> createState() => _MitredenWebviewState();
}

class _MitredenWebviewState extends State<MitredenWebview> {
  bool isLoading = true;

  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.link))
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
        setState(() {
          isLoading = false;
        });
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        WebViewWidget(controller: webViewController!),
        Center(
            child: (isLoading)
                ? AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Images.loading,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          Translate.of(context).translate('loading'),
                        ),
                      ],
                    ),
                  )
                : Container())
      ]),
    );
  }
}

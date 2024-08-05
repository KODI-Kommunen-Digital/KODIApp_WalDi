import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(Images.logo),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 300),
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

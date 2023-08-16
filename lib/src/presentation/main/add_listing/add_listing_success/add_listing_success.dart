import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class AddListingSuccessScreen extends StatefulWidget {
  const AddListingSuccessScreen({Key? key}) : super(key: key);

  @override
  State<AddListingSuccessScreen> createState() =>
      _AddListingSuccessScreenState();
}

class _AddListingSuccessScreenState extends State<AddListingSuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Add More
  void _onSuccess() {
    Navigator.pushNamed(context, Routes.submit,
        arguments: {'isNewList': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('completed'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Translate.of(context).translate('completed'),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Translate.of(context).translate(
                          'submit_success_message',
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AppButton(
                  Translate.of(context).translate('add_more'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _onSuccess,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

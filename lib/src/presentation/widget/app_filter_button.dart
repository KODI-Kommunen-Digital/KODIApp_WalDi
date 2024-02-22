import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class AppFilterButton extends StatelessWidget {
  final MultiFilter multiFilter;

  const AppFilterButton({super.key, required this.multiFilter});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.pushNamed(context, Routes.filterScreen, arguments: {
          "multifilter": multiFilter
        }).then((filter) => {
              //Do filter logic here
            });
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      icon: Icon(
        Icons.filter_list_rounded,
        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
      ),
    );
  }
}

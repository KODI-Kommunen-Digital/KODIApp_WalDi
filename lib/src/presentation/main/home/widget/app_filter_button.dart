import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class AppFilterButton extends StatelessWidget {
  final MultiFilter multiFilter;
  final Function(MultiFilter filter) filterCallBack;

  const AppFilterButton(
      {super.key, required this.multiFilter, required this.filterCallBack});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.pushNamed(context, Routes.filterScreen, arguments: {
          "multifilter": multiFilter
        }).then((filter) => {
          if (filter != null) {filterCallBack(filter as MultiFilter)}
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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel? item;
  final Function(CategoryModel)? onPressed;

  const HomeCategoryItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 48,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.22,
      child: GestureDetector(
        onTap: () => onPressed!(item!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 43,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: item!.color,
                  borderRadius: BorderRadius.circular(10)),
              child: FaIcon(
                item!.icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item!.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class AppFilterButton extends StatelessWidget {
  final ProductFilter? currentListProductFilter; //ListGroup filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final int? currentListingStatus; //Listing status in All Listings

  final List<CategoryModel>? cities; //All cities
  final int? currentLocation; //Location IDs

  const AppFilterButton(
      {super.key,
      this.currentLocation,
      this.currentListingStatus,
      this.currentForumGroupFilter,
      this.currentListProductFilter,
      this.cities});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.pushNamed(context, Routes.filterScreen, arguments: {
          "currentLocation": currentLocation,
          "currentListingStatus": currentListingStatus,
          "currentForumGroupFilter": currentForumGroupFilter,
          "currentListProductFilter": currentListProductFilter,
          "cities": cities
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

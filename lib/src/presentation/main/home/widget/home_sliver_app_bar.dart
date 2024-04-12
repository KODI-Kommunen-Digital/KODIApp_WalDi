import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/home/widget/city_dropdown.dart';
import 'package:heidi/src/presentation/main/home/widget/home_swiper.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String? banners;
  final ValueSetter<String>? setLocationCallback;
  final List<String>? cityTitlesList;
  String? hintText;
  String? selectedOption;

  AppBarHomeSliver(
      {required this.expandedHeight,
      this.setLocationCallback,
      this.cityTitlesList,
      this.banners,
      this.hintText,
      this.selectedOption});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Debugging output
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            HomeSwipe(
              images: banners,
              height:
                  expandedHeight - shrinkOffset, // Adjust based on shrinkOffset
            ),
            Container(
              height: 42,
              color: Theme.of(context).colorScheme.background,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CitiesDropDown(
                hintText: hintText,
                cityTitlesList: cityTitlesList,
                setLocationCallback: setLocationCallback,
                selectedOption: selectedOption,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

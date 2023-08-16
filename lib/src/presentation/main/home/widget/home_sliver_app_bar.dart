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
      required this.setLocationCallback,
      required this.cityTitlesList,
      this.banners,
      this.hintText,
      this.selectedOption});

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        HomeSwipe(
          images: banners,
          height: expandedHeight,
        ),
        Container(
          height: 32,
          color: Theme.of(context).colorScheme.background,
        ),
        CitiesDropDown(
          hintText: hintText,
          cityTitlesList: cityTitlesList,
          setLocationCallback: setLocationCallback,
          selectedOption: selectedOption,
          // onScan: onScan,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

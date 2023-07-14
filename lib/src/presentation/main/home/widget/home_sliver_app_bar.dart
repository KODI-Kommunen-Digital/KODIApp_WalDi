import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/home/widget/city_dropdown.dart';
import 'package:heidi/src/presentation/main/home/widget/home_swiper.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<String>? banners;
  final ValueSetter<String>? setLocationCallback;
  final List<String>? cityTitlesList;

  AppBarHomeSliver({
    required this.expandedHeight,
    required this.setLocationCallback,
    required this.cityTitlesList,
    this.banners,
  });

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
          cityTitlesList: cityTitlesList,
          setLocationCallback: setLocationCallback,
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

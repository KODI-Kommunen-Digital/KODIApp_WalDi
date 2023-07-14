import 'package:flutter/cupertino.dart';
import 'package:heidi/src/utils/color.dart';
import 'package:heidi/src/utils/icon.dart';

enum CategoryType { category, location, feature }

class CategoryModel {
  final int id;
  final String title;
  final int? count;
  final String image;
  final IconData? icon;
  final Color? color;
  final CategoryType? type;
  final bool hasChild;

  CategoryModel({
    required this.id,
    required this.title,
    this.count,
    required this.image,
    this.icon,
    this.color,
    this.type = CategoryType.category,
    this.hasChild = false,
  });

  @override
  bool operator ==(Object other) => other is CategoryModel && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    CategoryType categoryType = CategoryType.category;
    if (json['taxonomy'] == 'heidi_feature') {
      categoryType = CategoryType.feature;
    }
    if (json['taxonomy'] == 'heidi_location') {
      categoryType = CategoryType.location;
    }
    final icon = UtilIcon.getIconFromCss(json['icon']);
    final color = UtilColor.getColorFromHex(json['color']);
    return CategoryModel(
      id: json['id'] ?? json['id'] ?? 0,
      title: json['name'] ?? 'Unknown',
      count: json['count'] ?? 0,
      image: json['image'] ?? '',
      icon: icon,
      color: color,
      type: categoryType,
      hasChild: true,
    );
  }
}

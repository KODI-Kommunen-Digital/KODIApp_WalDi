import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';

import '../../presentation/main/home/forum/list_groups/cubit/list_groups_cubit.dart';

class MultiFilter {
  final ProductFilter? currentProductEventFilter; //ListProduct filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final int? currentListingStatus; //Listing status in All Listings
  final int? currentCategory; //Listing category in ListProduct city

  final List<CategoryModel>? cities; //All cities
  final List<CategoryModel>? categories;
  final int? currentLocation; //Location IDs

  final bool hasListingStatusFilter;
  final bool hasForumGroupFilter;
  final bool hasProductEventFilter;
  final bool hasLocationFilter;
  final bool hasCategoryFilter;

  MultiFilter(
      {this.currentLocation,
      this.cities,
      this.categories,
      this.currentForumGroupFilter,
      this.currentListingStatus,
      this.currentProductEventFilter,
      this.currentCategory,
      this.hasListingStatusFilter = false,
      this.hasForumGroupFilter = false,
      this.hasProductEventFilter = false,
      this.hasLocationFilter = false,
      this.hasCategoryFilter = false});
}

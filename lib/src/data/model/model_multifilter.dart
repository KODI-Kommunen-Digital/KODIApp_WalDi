import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';

class MultiFilter {
  final ProductFilter? currentProductEventFilter; //ListProduct filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final int? currentListingStatus; //Listing status in All Listings

  final List<CategoryModel>? cities; //All cities
  final int? currentLocation; //Location IDs

  final bool hasListingStatusFilter;
  final bool hasForumGroupFilter;
  final bool hasProductEventFilter;
  final bool hasLocationFilter;

  MultiFilter(
      {this.currentLocation,
      this.cities,
      this.currentForumGroupFilter,
      this.currentListingStatus,
      this.currentProductEventFilter,
      this.hasListingStatusFilter = false,
      this.hasForumGroupFilter = false,
      this.hasProductEventFilter = false,
      this.hasLocationFilter = false});
}

import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';

class MultiFilter {
  final ProductFilter? currentListProductFilter; //ListGroup filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final int? currentListingStatus; //Listing status in All Listings

  final List<CategoryModel>? cities; //All cities
  final int? currentLocation; //Location IDs

  final bool hasListingStatusFilter;
  final bool hasForumGroupFilter;
  final bool hasListProductFilter;
  final bool hasLocationFilter;

  MultiFilter(
      {this.currentLocation,
      this.cities,
      this.currentForumGroupFilter,
      this.currentListingStatus,
      this.currentListProductFilter,
      this.hasListingStatusFilter = false,
      this.hasForumGroupFilter = false,
      this.hasListProductFilter = false,
      this.hasLocationFilter = false});
}

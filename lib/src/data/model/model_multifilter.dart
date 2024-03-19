import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';

class MultiFilter {
  final ProductFilter? currentProductEventFilter; //ListProduct filter
  final int? currentListingStatus; //Listing status in All Listings
  final int? currentCategory; //Listing category in ListProduct city

  final List<CategoryModel>? cities; //All cities
  final List<CategoryModel>? categories;
  final int? currentLocation; //Location IDs

  final bool hasListingStatusFilter;
  final bool hasProductEventFilter;
  final bool hasLocationFilter;
  final bool hasCategoryFilter;

  MultiFilter(
      {this.currentLocation,
        this.cities,
        this.categories,
        this.currentListingStatus,
        this.currentProductEventFilter,
        this.currentCategory,
        this.hasListingStatusFilter = false,
        this.hasProductEventFilter = false,
        this.hasLocationFilter = false,
        this.hasCategoryFilter = false});
}
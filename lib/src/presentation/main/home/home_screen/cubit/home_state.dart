import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeStateInitial;

  const factory HomeState.loading() = HomeStateLoading;

  const factory HomeState.categoryLoading(List<CategoryModel>? location) = HomeStatecategoryLoading;

  const factory HomeState.categoryLoaded() = HomeStatecategoryLoaded;

  const factory HomeState.loaded(
      String banner,
      List<CategoryModel> category,
      List<CategoryModel> location,
      List<ProductModel> recent) = HomeStateLoaded;

  const factory HomeState.updated(
      String banner,
      List<CategoryModel> category,
      List<CategoryModel> location,
      List<ProductModel> recent) = HomeStateUpdated;

  const factory HomeState.error(String error) = HomeStateError;
}

// import 'package:heidi/src/data/model/model_favorite.dart';
// import 'package:heidi/src/data/model/model_product.dart';
//
//
// abstract class ProductDetailState {}
//
// class ProductDetailLoading extends ProductDetailState {}
//
// class ProductDetailSuccess extends ProductDetailState {
//   final ProductModel product;
//   final List<FavoriteModel>? favoritesList;
//   final bool isLoggedIn;
//
//   ProductDetailSuccess(this.product, this.favoritesList, this.isLoggedIn);
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = ProductDetailInitial;

  const factory ProductDetailState.loading() = ProductDetailLoading;

  const factory ProductDetailState.loaded(
      ProductModel product,
      List<FavoriteModel>? favoritesList,
      bool isLoggedIn
      ) = ProductDetailLoaded;

  const factory ProductDetailState.error(String error) = ProductDetailError;
}

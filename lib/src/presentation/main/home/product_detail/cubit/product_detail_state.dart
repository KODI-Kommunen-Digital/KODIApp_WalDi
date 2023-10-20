import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_user.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = ProductDetailInitial;

  const factory ProductDetailState.loading() = ProductDetailLoading;

  const factory ProductDetailState.loaded(
      ProductModel product,
      List<FavoriteModel>? favoritesList,
      UserModel? userDetail,
      bool isLoggedIn,
      String pdfPath) = ProductDetailLoaded;

  const factory ProductDetailState.error(String error) = ProductDetailError;
}

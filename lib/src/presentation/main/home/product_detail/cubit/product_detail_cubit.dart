import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailLoading());
  ProductModel? product;
  List<FavoriteModel> favoritesList = [];
  bool isFavorite = false;

  void onLoad(ProductModel item) async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, '');
    bool isLoggedIn = false;

    if (userId == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    if (item.cityId != null) {
      final result = await ListRepository.loadProduct(item.cityId, item.id);

      if (result != null) {
        if (userId != null) {
          favoritesList = await UserRepository.loadFavorites(userId);
          product = result;
          if (product != null) {
            for (final fList in favoritesList) {
              if (fList.listingsId == product?.id) {
                isFavorite = product!.favorite;
                product?.favorite = true;
              }
            }
          }
          emit(ProductDetailLoaded(product!, favoritesList, isLoggedIn));
        } else {
          product = result;
          emit(ProductDetailLoaded(product!, [], isLoggedIn));
        }
      }
    } else {
      isFavorite = true;
      emit(ProductDetailLoaded(item, [], isLoggedIn));
    }
  }

  bool getFavoriteIconValue() => isFavorite;

  void setFavoriteIconValue() {
    isFavorite = !isFavorite;
  }

  Future<void> onAddFavorite(ProductModel product) async {
    final prefs = await Preferences.openBox();
    final int? userId = prefs.getKeyValue(Preferences.userId, '');
    await ListRepository.addWishList(userId, product);
  }

  Future<void> onDeleteFavorite(ProductModel? product) async {
    final prefs = await Preferences.openBox();
    final int? userId = prefs.getKeyValue(Preferences.userId, '');

    if (product != null) {
      final favoritesList = await UserRepository.loadFavorites(userId);

      for (final fList in favoritesList) {
        if (fList.listingsId == product.id) {
          await ListRepository.removeWishList(userId, fList.favoriteId);
        }
      }
    }
  }
}

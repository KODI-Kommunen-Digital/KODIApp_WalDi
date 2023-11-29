import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailLoading());
  ProductModel? product;
  List<FavoriteModel> favoritesList = [];
  bool isFavorite = false;
  UserModel? userDetail;

  void onLoad(ProductModel item) async {
    final int userId = await UserRepository.getLoggedUserId();
    bool isLoggedIn = false;
    if (userId == 0) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }

    if (item.cityId != null) {
      final result = await ListRepository.loadProduct(item.cityId, item.id);

      if (result != null) {
        product = result;
        userDetail = await getUserDetails(item.userId, item.cityId);
        if (userId != 0) {
          try {
            favoritesList = await UserRepository.loadFavorites(userId);
            if (product != null) {
              for (final fList in favoritesList) {
                if (fList.listingsId == product?.id) {
                  product?.favorite = true;
                  isFavorite = product!.favorite;
                }
              }
            }
            if(favoritesList.isNotEmpty){
              emit(ProductDetailLoaded(
                  product!, favoritesList, userDetail, isLoggedIn));
            }
            else{
              final int userId = await UserRepository.getLoggedUserId();
              if (userId == 0) {
                isLoggedIn = false;
              } else {
                isLoggedIn = true;
              }
              emit(ProductDetailLoaded(
                  product!, null, userDetail, isLoggedIn));
            }
          }
          catch (e){
            emit(ProductDetailLoaded(
                product!, null, userDetail, isLoggedIn));
          }
          emit(ProductDetailLoaded(
              product!, favoritesList, userDetail, isLoggedIn));
        } else {
          emit(ProductDetailLoaded(product!, null, userDetail, isLoggedIn));
        }
      }
    } else {
      isFavorite = true;
      emit(ProductDetailLoaded(item, null, userDetail, isLoggedIn));
    }
  }

  bool getFavoriteIconValue() => isFavorite;

  void setFavoriteIconValue() {
    isFavorite = !isFavorite;
  }

  Future<int> getLoggedInUserId() async {
    return await UserRepository.getLoggedUserId();
  }

  Future<UserModel?> getUserDetails(userId, cityId) async {
    UserModel? userDetailResponse =
        await UserRepository.getUserDetails(userId, cityId);
    return userDetailResponse;
  }

  Future<void> onAddFavorite(ProductModel product) async {
    final prefs = await Preferences.openBox();
    final int? userId = prefs.getKeyValue(Preferences.userId, '');
    await ListRepository.addWishList(userId, product);
    await AppBloc.wishListCubit.onLoad();
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
      await AppBloc.wishListCubit.onLoad();
    }
  }
}

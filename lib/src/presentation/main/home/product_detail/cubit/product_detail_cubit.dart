import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailLoading());
  ProductModel? product;
  List<FavoriteModel> favoritesList = [];
  bool isFavorite = false;
  UserModel? userDetail;

  void onLoad(ProductModel item) async {
    final int userId = await UserRepository.getLoggedUserId();
    final cityList = await getCityList() ?? [];
    bool isLoggedIn = false;
    if (userId == 0) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    bool darkModeEnabled = await isDarkMode();

    if (item.cityId != null) {
      final result = await ListRepository.loadProduct(item.cityId, item.id);

      if (result != null) {
        product = result;
        if (product!.categoryId == 18) {
          /* AppointmentModel? appointment =
              await AppointmentRepository.loadAppointment(
                  item.cityId!, item.id);*/
          product!.isBookable = true;
        }
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
            if (favoritesList.isNotEmpty) {
              emit(ProductDetailLoaded(product!, favoritesList, userDetail,
                  isLoggedIn, cityList, darkModeEnabled));
            } else {
              final int userId = await UserRepository.getLoggedUserId();
              if (userId == 0) {
                isLoggedIn = false;
              } else {
                isLoggedIn = true;
              }
              emit(ProductDetailLoaded(product!, null, userDetail, isLoggedIn,
                  cityList, darkModeEnabled));
            }
          } catch (e, stackTrace) {
            emit(ProductDetailLoaded(product!, null, userDetail, isLoggedIn,
                cityList, darkModeEnabled));
            await Sentry.captureException(e, stackTrace: stackTrace);
          }
        } else {
          emit(ProductDetailLoaded(product!, null, userDetail, isLoggedIn,
              cityList, darkModeEnabled));
        }
      }
    } else {
      isFavorite = true;
      emit(ProductDetailLoaded(
          item, null, userDetail, isLoggedIn, cityList, darkModeEnabled));
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await Preferences.openBox();
    bool isLoggedIn =
        prefs.getKeyValue(Preferences.userId, 0).toString() != "0";
    return isLoggedIn;
  }

  Future<bool> isDarkMode() async {
    final prefBox = await Preferences.openBox();
    String darkMode = await prefBox.getKeyValue(Preferences.darkOption, 'on');
    return (darkMode == 'on');
  }

  Future<List?> getCityList() async {
    ResultApiModel? loadCitiesResponse;
    try {
      loadCitiesResponse = await loadCities();
    } catch (e, stackTrace) {
      logError('load cities error', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);

      return null;
    }

    List listCity = loadCitiesResponse.data;
    return listCity;
  }

  String getCityNameFromId(List listCity, int cityId) {
    if (listCity.isNotEmpty) {
      final city = listCity.firstWhere((cityData) => cityData["id"] == cityId);
      return city["name"];
    }
    return "";
  }

  Future<ResultApiModel> loadCities() async {
    final response = await Api.requestSubmitCities();
    return response;
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

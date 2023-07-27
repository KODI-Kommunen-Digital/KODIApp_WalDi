import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic sliders;

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad() async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }
    final categoryRequestResponse = await Api.requestHomeCategory();
    final cityRequestResponse = await Api.requestCities();
    final listingsRequestResponse = await Api.requestRecentListings();
    final imageRequestResponse = await Api.requestSliderImages();

    category = List.from(categoryRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    recent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    final banner =
        List<String>.from(imageRequestResponse.data['sliders'] ?? []);

    emit(HomeStateLoaded(
      banner,
      category,
      location,
      recent,
    ));
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('dns.google');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}

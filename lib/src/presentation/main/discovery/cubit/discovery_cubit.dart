import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import '../../../../data/model/model_category.dart';
import 'discovery_state.dart';

enum LocationFilter {
  week,
  month,
}

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  List<CitizenServiceModel> list = [];
  List<CitizenServiceModel> listLoaded = [];
  List<CitizenServiceModel> filteredList = [];
  dynamic location;

  Future<void> onLoad() async {
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    emit(DiscoveryStateLoaded(
      location,
    ));
  }

  // void onLocationFilter(String locationName, List<ProductModel> loadedList)
  void onLocationFilter(String locationName) {}

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    Map<int, String> cityWebsites = {
      0: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger",
      1: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86974&behoerde=29997690498&gemeinde=325524110678",
      2: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86925&behoerde=70664072559&gemeinde=006746347678",
      3: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86944&behoerde=93996542745&gemeinde=208079671678",
    };

    return cityWebsites[cityId];
  }

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    return cityId;
  }
}

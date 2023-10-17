import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import '../../../../data/model/model_category.dart';
import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  List<CitizenServiceModel> list = [];
  List<CitizenServiceModel> listLoaded = [];
  List<CitizenServiceModel> filteredList = [];
  List<CategoryModel> location = [];
  final List<CitizenServiceModel> hiddenServices = [];
  late List<CitizenServiceModel> services;
  bool doesScroll = false;

  Future<void> onLoad() async {
    emit(const DiscoveryStateLoading());
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    services = initializeServices();

    for (var element in services) {
      if (element.categoryId != null || element.type == "subCategoryService") {
        bool hasContent = await element.hasContent();
        if (!hasContent) {
          hiddenServices.add(element);
        }
      }
    }

    ///TODO: unComment this line
    // services.removeWhere((element) => hiddenServices.contains(element));

    emit(DiscoveryStateLoaded(
      services,
    ));
  }

  Future<void> onLocationFilter(int locationId, bool calledExternal) async {
    await saveCityId(locationId);
    emit(const DiscoveryState.loading());
    await onLoad();
    if (calledExternal) {
      AppBloc.homeCubit.setCalledExternally(true);
      await AppBloc.homeCubit.onLoad(false);
    }
  }

  Future<void> updateLocationFilter(int locationId) async {
    emit(const DiscoveryState.loading());
    await onLocationFilter(locationId, true);
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    Map<int, String> cityWebsites = {
      0: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger",
      1: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86974&behoerde=29997690498&gemeinde=325524110678",
      2: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86925&behoerde=70664072559&gemeinde=006746347678",
      3: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86944&behoerde=93996542745&gemeinde=208079671678",
    };

    return cityWebsites[cityId];
  }

  Future<void> setServiceValue(String preference, String? type, int? id) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(preference, type ?? id);
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  void scrollUp() {
    emit(const DiscoveryStateLoading());
    emit(DiscoveryStateLoaded(services));
  }

  List<CitizenServiceModel> initializeServices() {
    return [
      CitizenServiceModel(imageUrl: Images.service2, imageLink: "2"),
      CitizenServiceModel(
          imageUrl: Images.service3,
          imageLink: "3",
          type: "subCategoryService",
          arguments: 4),
      CitizenServiceModel(
          imageUrl: Images.service4,
          imageLink: "4",
          arguments: 4,
          categoryId: 1),
      CitizenServiceModel(
          imageUrl: Images.service5,
          imageLink: "5",
          arguments: 5,
          categoryId: 3),
      CitizenServiceModel(
          imageUrl: Images.service6,
          imageLink: "6",
          arguments: 6,
          categoryId: 4),
      CitizenServiceModel(
          imageUrl: Images.service7,
          imageLink: "7",
          arguments: 7,
          categoryId: 10),
      CitizenServiceModel(
          imageUrl: Images.service8,
          imageLink: "8",
          arguments: 8,
          categoryId: 13),
      CitizenServiceModel(
          imageUrl: Images.service9,
          imageLink: "9",
          arguments: 9,
          categoryId: 6),
      CitizenServiceModel(
        imageUrl: Images.service10,
        imageLink: "10",
        arguments: 10,
      ),
    ];
  }

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    return cityId;
  }
}

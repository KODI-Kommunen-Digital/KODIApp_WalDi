import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/remote/local/link_manager.dart';
import 'package:heidi/src/presentation/cubit/bloc.dart';
import 'package:heidi/src/data/remote/local/service_manager.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  List<CitizenServiceModel> list = [];
  List<CitizenServiceModel> listLoaded = [];
  List<CitizenServiceModel> filteredList = [];
  dynamic location;
  final List<CitizenServiceModel> hiddenServices = [];
  late List<CitizenServiceModel> services;
  bool doesScroll = false;
  int? currentCity;

  Future<void> onLoad() async {
    emit(const DiscoveryStateLoading());
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    services = await ServiceManager.initializeServices();
    List<CitizenServiceModel> servicesCopy = List.from(services);

    for (var element in servicesCopy) {
      if (element.categoryId != null || element.type == "subCategoryService") {
        bool hasContent = await element.hasContent();
        if (!hasContent) {
          hiddenServices.add(element);
        }
      }
    }
    services.removeWhere((element) => hiddenServices.contains(element));

    await getCitySelected();

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

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    currentCity = cityId;
    return cityId;
  }

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    Map<int, String> cityWebsites = {
      0: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger",
      1: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94572&behoerde=71996696712&gemeinde=898745703691",
      2: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94548&behoerde=64441660600&gemeinde=663856825691",
      3: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94536&behoerde=11664135546&gemeinde=529634609691",
      4: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94513&behoerde=06218912714&gemeinde=361856839691",
      5: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94481&behoerde=12775705447&gemeinde=210856846691",
      6: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94160&behoerde=45218989697&gemeinde=935745794689",
      7: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94157&behoerde=30552425675&gemeinde=902190240689",
      8: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94133&behoerde=80107867699&gemeinde=667301362689",
      9: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94116&behoerde=46330559598&gemeinde=566634700689",
      10: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94142&behoerde=04219626560&gemeinde=751190247689",
      11: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94163&behoerde=17663393706&gemeinde=969301348689",
      12: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94169&behoerde=22885462739&gemeinde=036412456690"
    };

    return cityWebsites[cityId];
  }

  Future<String?> getToruismLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    Map<int, String> cityWebsites = {
      0: "https://www.ilztal.de",
      1: "https://www.region-sonnenwald.de/",
      2: "https://www.ilztal.de",
      3: "https://www.ferienregion-nationalpark.de/index.html",
      4: "https://www.ferienregion-nationalpark.de/index.html",
      5: "https://www.grafenau.de/tourismus-grafenau/de/startseite",
      6: "https://www.ilztal.de",
      7: "https://www.ilztal.de",
      8: "https://www.ilztal.de",
      9: "https://www.ilztal.de",
      10: "https://www.ilztal.de",
      11: "https://tourmkr.com/F14GDqSiQS/40669119p&26.93h&72.5t",
      12: "https://www.ilztal.de"
    };

    return cityWebsites[cityId];
  }

  Future<void> hideEmptyService() async {}

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

  // List<CitizenServiceModel> initializeServices() {
  //   return [
  //     CitizenServiceModel(imageUrl: Images.service1, imageLink: "1"),
  //     CitizenServiceModel(imageUrl: Images.service2, imageLink: "2"),
  //     CitizenServiceModel(
  //         imageUrl: Images.service3,
  //         imageLink: "3",
  //         categoryId: 16,
  //         arguments: 4),
  //     CitizenServiceModel(
  //         imageUrl: Images.service4,
  //         imageLink: "4",
  //         arguments: 4,
  //         categoryId: 1),
  //     CitizenServiceModel(
  //         imageUrl: Images.service5,
  //         imageLink: "5",
  //         arguments: 5,
  //         categoryId: 3),
  //     CitizenServiceModel(
  //         imageUrl: Images.service6,
  //         imageLink: "6",
  //         arguments: 6,
  //         categoryId: 4),
  //     CitizenServiceModel(
  //         imageUrl: Images.service7,
  //         imageLink: "7",
  //         arguments: 7,
  //         categoryId: 10),
  //     CitizenServiceModel(
  //         imageUrl: Images.service8,
  //         imageLink: "8",
  //         arguments: 8,
  //         categoryId: 13),
  //     CitizenServiceModel(
  //         imageUrl: Images.service9,
  //         imageLink: "9",
  //         arguments: 9,
  //         categoryId: 6),
  //     CitizenServiceModel(
  //         imageUrl: Images.service13,
  //         imageLink: "13",
  //         arguments: 10,
  //         categoryId: 15),
  //     CitizenServiceModel(
  //         imageUrl: Images.service14,
  //         imageLink: "14",
  //         arguments: 11,
  //         categoryId: 14),
  //     CitizenServiceModel(
  //       imageUrl: Images.service11,
  //       imageLink: "11",
  //     ),
  //     CitizenServiceModel(
  //       imageUrl: Images.service12,
  //       imageLink: "12",
  //     ),
  //   ];
  // }

  Future<String?> getMitredenLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    return LinkManager.getMitredenLink(cityId); // Fetch from LinkManager
  }

  Future<String?> getVirtualTourLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    return LinkManager.getVirtualTourLink(cityId); // Fetch from LinkManager
  }
}

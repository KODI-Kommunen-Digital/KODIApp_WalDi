import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/cubit/bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import '../../../../data/model/model_category.dart';
import 'discovery_state.dart';

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

  Future<void> onLocationFilter(int locationId) async {
    if (locationId == 0) {
      await saveCityId(0);
    } else {
      await saveCityId(locationId);
    }
    emit(const DiscoveryState.loading());
    await onLoad();
    AppBloc.homeCubit.setCalledExternally(true);
    await AppBloc.homeCubit.onLoad();
  }

  Future<void> updateLocationFilter(int locationId) async {
    emit(const DiscoveryState.loading());
    await onLocationFilter(locationId);
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    return cityId;
  }

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
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

  List<CitizenServiceModel> initializeServices() {
    return [
      CitizenServiceModel(imageUrl: Images.service1, imageLink: "1"),
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
    ];
  }

  Future<String?> getMitredenLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    Map<int, String> cityWebsites = {
      0: "https://mitreden.ilzerland.bayern/projekts?order=index_order_all",
      1: "https://mitreden.ilzerland.bayern/schoefweg",
      2: "https://mitreden.ilzerland.bayern/innernzell",
      3: "https://mitreden.ilzerland.bayern/eppenschlag",
      4: "https://mitreden.ilzerland.bayern/projekts?order=index_order_all",
      5: "https://mitreden.ilzerland.bayern/grafenau",
      6: "https://mitreden.ilzerland.bayern/ringelai",
      7: "https://mitreden.ilzerland.bayern/perlesreut",
      8: "https://mitreden.ilzerland.bayern/roehrnbach",
      9: "https://mitreden.ilzerland.bayern/hutthurm",
      10: "https://mitreden.ilzerland.bayern/fuersteneck",
      11: "https://mitreden.ilzerland.bayern/saldenburg",
      12: "https://mitreden.ilzerland.bayern/thurmansbang",
    };

    return cityWebsites[cityId];
  }
}

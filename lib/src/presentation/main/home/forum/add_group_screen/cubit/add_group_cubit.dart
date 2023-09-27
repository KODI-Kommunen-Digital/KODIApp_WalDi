import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/presentation/main/home/forum/add_group_screen/cubit/add_group_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  final ForumRepository _repo;

  AddGroupCubit(this._repo) : super(const AddGroupState.loaded());

  String? selectedCity;
  int? cityId;
  List listCity = [];

  Future<bool> onSubmit(
      {required String title,
      required String description,
      required int cityId,
      String? city,
      String? type}) async {
    try {
      final response = await _repo.saveForum(title, description, city, type);
      if (response.success) {
        return true;
      } else {
        logError('Save Forum Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('Save Forum Error', e);
      return false;
    }
  }

  Future<int?> getCurrentCityId() async {
    final prefs = await Preferences.openBox();
    return prefs.getKeyValue(Preferences.cityId, 0);
  }

  void setImagePref(imagePath) async {
    await _repo.setImagePrefs(imagePath);
  }

  Future<void> deleteImage(cityId, listingId) async {
    await _repo.deleteImage(cityId, listingId);
  }

  void clearCityId() async {
    _repo.clearCityId();
  }

  Future<List<dynamic>?> loadCities() async {
    try {
      final loadForumCitiesResponse = await _repo.loadForumCities();
      if (loadForumCitiesResponse.success) {
        return loadForumCitiesResponse.data;
      }
    } catch (e) {
      logError('load cities error', e.toString());
    }
    return null;
  }

  Future<void> clearImagePath() async {
    _repo.clearImagePath();
  }
}

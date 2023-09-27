import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/add_new_post/cubit/add_post_state.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final ForumRepository _repo;

  AddPostCubit(this._repo) : super(const AddPostState.loaded());

  String? selectedCity;
  int? cityId;
  List listCity = [];
  List listVillage = [];

  Future<bool> onSubmit(
      {required String title,
      required String description,
      required int cityId,
      required int? forumId}) async {
    try {
      final response =
          await _repo.savePost(title, description, cityId, forumId);
      if (response.success) {
        return true;
      } else {
        logError('Save Post Response Failed', response.message);
        return false;
      }
    } catch (e) {
      logError('Save Post Error', e);
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

  Future<void> clearImagePath() async {
    _repo.clearImagePath();
  }
}

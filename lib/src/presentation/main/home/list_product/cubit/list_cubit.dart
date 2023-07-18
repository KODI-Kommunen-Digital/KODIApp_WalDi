import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_filter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

import 'cubit.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(const ListStateLoading());

  int page = 1;
  List<ProductModel> list = [];
  PaginationModel? pagination;

  Future<void> onLoad(int selectedCityId) async {
    page = 1;
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    final type = prefs.getKeyValue(Preferences.type, '');
    final result = await ListRepository.loadList(
      categoryId: categoryId,
      cityId: selectedCityId,
      type: type,
    );
    if (result != null) {
      list = result[0];
      pagination = result[1];

      emit(ListStateLoaded(
        list,
      ));
    }
  }

  Future<void> onLoadMore(FilterModel filter) async {
    page = page + 1;
    emit(ListStateLoaded(list));
  }

  Future<void> onUpdate(int id) async {
    try {
      final exist = list.firstWhere((e) => e.id == id);
      final cityId = list.firstWhere((e) => e.id == id).cityId;
      final result = await ListRepository.loadProduct(cityId, id);

      if (result != null) {
        list = list.map((e) {
          if (e.id == exist.id) {
            return result;
          }
          return e;
        }).toList();

        emit(ListStateLoaded(
          list,
        ));
      }
    } catch (error) {
      logError("LIST NOT FOUND Error");
    }
  }
}

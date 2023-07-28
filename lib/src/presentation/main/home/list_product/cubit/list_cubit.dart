import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'cubit.dart';

enum ProductFilter {
  week,
  month,
}

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(const ListStateLoading()) {
    // final isEvent = categoryPreferencesCall();
  }

  int page = 1;
  List<ProductModel> list = [];
  PaginationModel? pagination;
  List<ProductModel> listLoaded = [];
  List<ProductModel> filteredList = [];

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
      listLoaded = list;
      emit(ListStateLoaded(
        list,
      ));
    }
  }


  List<ProductModel> getLoadedList() => listLoaded;

  void onProductFilter(ProductFilter? type, List<ProductModel> loadedList) {

    final currentDate = DateTime.now();
    if (type == ProductFilter.month) {
       filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startMonth = startDate.month;
          final currentMonth = currentDate.month;
          return startMonth == currentMonth;
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList));
       logError('month2', filteredList.length);
    } else if (type == ProductFilter.week) {
       filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startWeek = _getWeekNumber(startDate);
          final currentWeek = _getWeekNumber(currentDate);
          return startWeek == currentWeek;
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList));
    } else {
      emit(ListStateUpdated(loadedList));
    }
  }

  DateTime? _parseDate(String dateString) {
    try {
      final parts = dateString.split('.');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      logError("Error parsing date: $dateString");
    }
    return null;
  }

  int _getWeekNumber(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(startOfYear).inDays;
    return (daysSinceStartOfYear / 7).ceil();
  }

  Future<bool?> categoryPreferencesCall() async {
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    if (categoryId == 3) {
      return true;
    } else {
      return null;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_users_joined_group.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';

import 'cubit.dart';

enum GroupFilter {
  myGroups,
  allGroups,
}

class ListGroupsCubit extends Cubit<ListGroupsState> {
  final ForumRepository repo;

  ListGroupsCubit(this.repo) : super(const ListGroupsStateLoading()) {
    // final isEvent = categoryPreferencesCall();
    onLoad();
  }

  int pageNo = 1;
  List<ForumGroupModel> groupsList = [];
  PaginationModel? pagination;
  List<ForumGroupModel> listLoaded = [];
  var userJoinedGroupsList = <UserJoinedGroupsModel>[];

  Future<void> onLoad() async {
    pageNo = 1;
    final result = await repo.loadForumsList(
      pageNo: pageNo,
    );
    if (result != null) {
      groupsList = result[0];
      pagination = result[1];
      userJoinedGroupsList = result[2];
      // listLoaded = list;
      for (final list in groupsList) {
        bool joined =
            userJoinedGroupsList.any((element) => element.forumId == list.id);
        listLoaded.add(ForumGroupModel(
            id: list.id,
            forumName: list.forumName,
            createdAt: list.createdAt,
            description: list.description,
            image: list.image,
            isPrivate: list.isPrivate,
            isJoined: joined));
      }
      emit(ListGroupsStateLoaded(
        listLoaded,
      ));
    }
  }

// Future<void> newListings(int pageNo, cityId) async {
//   final prefs = await Preferences.openBox();
//   final type = prefs.getKeyValue(Preferences.type, '');
//   if (type == 'location') {
//     prefs.setKeyValue(Preferences.categoryId, '');
//   }
//
//   final result = await repo.loadForumsList(
//     pageNo: pageNo,
//   );
//
//   final listUpdated = result?[0];
//   if (listUpdated.isNotEmpty) {
//     list.addAll(listUpdated);
//     listLoaded = list;
//     emit(ListGroupsStateUpdated(list));
//   }
// }
//
// List<ForumGroupModel> getLoadedList() => listLoaded;

/*  void onGroupFilter(GroupFilter? type, List<ProductModel> loadedList) {
    final currentDate = DateTime.now();
    if (type == GroupFilter.mygroups) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startMonth = startDate.month;
          final currentMonth = currentDate.month;
          return startMonth == currentMonth;
        }
        return false;
      }).toList();

      emit(ListGroupsStateUpdated(filteredList));
    } else if (type == GroupFilter.allgroups) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startWeek = _getWeekNumber(startDate);
          final currentWeek = _getWeekNumber(currentDate);
          return startWeek == currentWeek;
        }
        return false;
      }).toList();

      emit(ListGroupsStateUpdated(filteredList));
    } else {
      emit(ListGroupsStateUpdated(loadedList));
    }
  }*/

/*  DateTime? _parseDate(String dateString) {
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

  Future<String?> getCategory() async {
    final categoryId = await repo.getCategoryId();
    Map<int, String> categories = {
      1: "category_news",
      2: "category_traffic",
      3: "category_events",
      4: "category_clubs",
      5: "category_products",
      6: "category_offer_search",
      7: "category_citizen_info",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food"
    };
    return categories[categoryId];
  }*/
}

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:intl/intl.dart';

import 'cubit.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(const WishListLoading());
  bool doesScroll = false;

  dynamic response;

  Future<void> onLoad() async {
    final prefBox = await Preferences.openBox();

    final userId = prefBox.getKeyValue(Preferences.userId, 0);
    response = await UserRepository.loadFavoritesListDetail(userId);
    emit(WishListState.loaded(response));
  }

  String onDateParse(String date) {
    final parsedDateTime = DateTime.parse(date);
    var createDate = DateFormat('dd.MM.yyyy').format(parsedDateTime);
    return createDate;
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  void scrollUp() {
    emit(const WishListLoading());
    emit(WishListState.loaded(response));
  }
}
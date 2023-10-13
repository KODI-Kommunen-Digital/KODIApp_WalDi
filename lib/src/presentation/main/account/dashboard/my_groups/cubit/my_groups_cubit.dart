import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_request_member.dart';
import 'package:heidi/src/data/model/model_users_joined_group.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_state.dart';

enum GroupFilter {
  myGroups,
  allGroups,
}

class MyGroupsCubit extends Cubit<MyGroupsState> {
  final ForumRepository repo;

  MyGroupsCubit(this.repo) : super(const MyGroupsStateLoading()) {
    onLoad();
  }

  int pageNo = 1;
  List<ForumGroupModel> groupsList = [];
  PaginationModel? pagination;
  List<ForumGroupModel> listLoaded = [];
  List<ForumGroupModel> filteredList = [];
  List<RequestMemberModel> requestMemberList = [];
  var userJoinedGroupsList = <UserJoinedGroupsModel>[];

  Future<void> onLoad() async {
    listLoaded.clear();
    emit(const MyGroupsStateLoading());
    pageNo = 1;
    final result = await repo.loadForumsList(
      pageNo: pageNo,
    );
    if (AppBloc.userCubit.state == null) {
      if (result != null) {
        groupsList = result[1];

        for (final list in groupsList) {
          bool joined =
              userJoinedGroupsList.any((element) => element.forumId == list.id);
          bool requested =
              requestMemberList.any((element) => element.forumId == list.id);

          listLoaded.add(ForumGroupModel(
              id: list.id,
              forumName: list.forumName,
              createdAt: list.createdAt,
              description: list.description,
              image: list.image,
              isPrivate: list.isPrivate,
              isJoined: joined,
              isRequested: requested));
        }
        emit(MyGroupsStateLoaded(
          listLoaded.reversed.toList(),
          result[0],
        ));
      }
    } else {
      if (result != null) {
        groupsList = result[1];
        pagination = result[2];
        userJoinedGroupsList = result[3];
        requestMemberList = result[4];

        for (final list in groupsList) {
          bool joined =
              userJoinedGroupsList.any((element) => element.forumId == list.id);
          int? cityId = 0;
          for (final userGroup in userJoinedGroupsList) {
            if (userGroup.forumId == list.id) {
              cityId = userGroup.cityId;
            }
          }
          bool requested =
              requestMemberList.any((element) => element.forumId == list.id);

          listLoaded.add(ForumGroupModel(
              id: list.id,
              forumName: list.forumName,
              createdAt: list.createdAt,
              description: list.description,
              image: list.image,
              isPrivate: list.isPrivate,
              cityId: cityId,
              isJoined: joined,
              isRequested: requested));
        }

        filteredList = listLoaded.where((product) {
          return product.isJoined == true;
        }).toList();

        emit(MyGroupsStateLoaded(
          filteredList.reversed.toList(),
          result[0],
        ));
      }
    }
  }

  Future<int> getLoggedInUserId() async {
    final userId = await repo.getLoggedInUserId();
    return userId;
  }

  Future<String> requestToJoinGroup(forumId) async {
    final response = await repo.requestToJoinGroup(forumId);
    if (response!.success) {
      final data = response.data;
      return data['message'];
    } else {
      return '';
    }
  }

  List<ForumGroupModel> getLoadedList() => listLoaded;

  Future<void> onGroupFilter(
      GroupFilter? type, List<ForumGroupModel> loadedList) async {
    final userId = await getLoggedInUserId();
    if (type == GroupFilter.myGroups) {
      filteredList = loadedList.where((product) {
        return product.isJoined == true;
      }).toList();
      emit(MyGroupsStateUpdated(filteredList, userId));
    } else if (type == GroupFilter.allGroups) {
      emit(MyGroupsStateUpdated(loadedList, userId));
    } else {
      emit(MyGroupsStateUpdated(loadedList, userId));
    }
  }
}

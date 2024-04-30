import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_forum_status.dart';
import 'package:heidi/src/data/model/model_request_member.dart';
import 'package:heidi/src/data/model/model_users_joined_group.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';

import 'cubit.dart';

enum GroupFilter {
  myGroups,
  allGroups,
}

class ListGroupsCubit extends Cubit<ListGroupsState> {
  final ForumRepository repo;

  ListGroupsCubit(this.repo) : super(const ListGroupsStateLoading()) {
    onLoad();
  }

  int pageNo = 1;
  List<ForumGroupModel> groupsList = [];
  PaginationModel? pagination;
  List<ForumGroupModel> listLoaded = [];
  List<ForumGroupModel> filteredList = [];
  List<RequestMemberModel> requestMemberList = [];
  List<ForumStatusModel> forumsWithStatusResponse = [];
  var userJoinedGroupsList = <UserJoinedGroupsModel>[];

  Future<void> onLoad() async {
    listLoaded.clear();
    emit(const ListGroupsStateLoading());
    pageNo = 1;
    bool joined = false;
    bool requested = false;
    final result = await repo.loadForumsList(
      pageNo: pageNo,
    );
    if (AppBloc.userCubit.state == null) {
      if (result != null) {
        groupsList = result[1];

        for (final list in groupsList) {
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
        emit(ListGroupsStateLoaded(
          listLoaded.reversed.toList(),
          result[0],
        ));
      }
    } else {
      if (result != null) {
        groupsList = result[1];
        pagination = result[2];
        forumsWithStatusResponse = result[3];

        for (final list in groupsList) {
          int index = forumsWithStatusResponse
              .indexWhere((element) => element.forumIds == list.id);
          if (forumsWithStatusResponse[index].statusId == 0) {
            joined = false;
            requested = false;
          } else if (forumsWithStatusResponse[index].statusId == 1) {
            requested = true;
            joined = false;
          } else if (forumsWithStatusResponse[index].statusId == 2) {
            joined = true;
            requested = false;
          }
          int? cityId = 0;
          for (final userGroup in userJoinedGroupsList) {
            if (userGroup.forumId == list.id) {
              cityId = userGroup.cityId;
            }
          }

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

        emit(ListGroupsStateLoaded(
          listLoaded.reversed.toList(),
          result[0],
        ));
      }
    }
  }

  Future<List<ForumGroupModel>> newListings(int pageNo) async {
    bool joined = false;
    bool requested = false;
    final result = await repo.loadForumsList(
      pageNo: pageNo,
    );

    if (result != null) {
      groupsList = result[1];
      pagination = result[2];
      forumsWithStatusResponse = result[3];

      for (final list in groupsList) {
        int index = forumsWithStatusResponse
            .indexWhere((element) => element.forumIds == list.id);
        if (forumsWithStatusResponse[index].statusId == 0) {
          joined = false;
          requested = false;
        } else if (forumsWithStatusResponse[index].statusId == 1) {
          requested = true;
          joined = false;
        } else if (forumsWithStatusResponse[index].statusId == 2) {
          joined = true;
          requested = false;
        }
        int? cityId = 0;
        for (final userGroup in userJoinedGroupsList) {
          if (userGroup.forumId == list.id) {
            cityId = userGroup.cityId;
          }
        }

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
      return listLoaded.reversed.toList();
    }
    return listLoaded.reversed.toList();
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

  List<ForumGroupModel> getLoadedList() => listLoaded.reversed.toList();

  Future<void> onGroupFilter(
      GroupFilter? type, List<ForumGroupModel> loadedList) async {
    final userId = await getLoggedInUserId();
    if (type == GroupFilter.myGroups) {
      filteredList = loadedList.where((product) {
        return product.isJoined == true;
      }).toList();
      emit(ListGroupsStateUpdated(filteredList, userId));
    } else if (type == GroupFilter.allGroups) {
      emit(ListGroupsStateUpdated(loadedList, userId));
    } else {
      emit(ListGroupsStateUpdated(loadedList, userId));
    }
  }
}

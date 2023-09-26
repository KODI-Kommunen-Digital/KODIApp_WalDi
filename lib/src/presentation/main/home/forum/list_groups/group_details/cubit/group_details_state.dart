import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';

part 'group_details_state.freezed.dart';

@freezed
class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState.initial() = GroupDetailsStateInitial;

  const factory GroupDetailsState.loading() = GroupDetailsStateLoading;

  const factory GroupDetailsState.loaded(
      List<ForumGroupModel> list,
      ) = GroupDetailsStateLoaded;

  const factory GroupDetailsState.updated(
      List<ForumGroupModel> list,
      ) = GroupDetailsStateUpdated;

  const factory GroupDetailsState.error(String error) = GroupDetailsStateError;
}

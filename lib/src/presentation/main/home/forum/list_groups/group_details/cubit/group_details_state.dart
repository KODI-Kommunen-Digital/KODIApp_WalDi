import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';

part 'group_details_state.freezed.dart';

@freezed
class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState.initial() = GroupDetailsStateInitial;

  const factory GroupDetailsState.loading() = GroupDetailsStateLoading;

  const factory GroupDetailsState.loaded(
      List<GroupPostsModel> list,
      ) = GroupDetailsStateLoaded;

  const factory GroupDetailsState.error(String error) = GroupDetailsStateError;
}

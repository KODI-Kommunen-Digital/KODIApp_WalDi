import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_member_request.dart';

part 'member_request_state.freezed.dart';

@freezed
class MemberRequestState with _$MemberRequestState {
  const factory MemberRequestState.initial() = MemberRequestStateInitial;

  const factory MemberRequestState.loading() = MemberRequestLoading;

  const factory MemberRequestState.loaded(
    List<MemberRequestModel> list,
  ) = MemberRequestLoaded;

  const factory MemberRequestState.error(String error) = MemberRequestError;
}

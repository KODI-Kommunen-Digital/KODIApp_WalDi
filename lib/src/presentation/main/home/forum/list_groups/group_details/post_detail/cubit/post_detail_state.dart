import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_user.dart';

part 'post_detail_state.freezed.dart';

@freezed
class PostDetailState with _$PostDetailState {
  const factory PostDetailState.initial() = PostDetailInitial;

  const factory PostDetailState.loading() = PostDetailLoading;

  const factory PostDetailState.loaded(
      UserModel? userDetail,
    ) = PostDetailLoaded;

  const factory PostDetailState.error(String error) = PostDetailError;
}

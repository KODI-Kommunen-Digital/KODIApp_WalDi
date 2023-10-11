import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_state.freezed.dart';

@freezed
abstract class AddPostState with _$AddPostState {
  const factory AddPostState.loading() = AddPostLoading;

  const factory AddPostState.loaded() = AddPostLoaded;

  const factory AddPostState.error(String error) = AddPostError;
}

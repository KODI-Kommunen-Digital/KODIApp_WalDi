import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_group_state.freezed.dart';

@freezed
abstract class AddGroupState with _$AddGroupState {
  const factory AddGroupState.loading() = AddGroupLoading;

  const factory AddGroupState.loaded() = AddGroupLoaded;

  const factory AddGroupState.error(String error) = AddGroupError;
}

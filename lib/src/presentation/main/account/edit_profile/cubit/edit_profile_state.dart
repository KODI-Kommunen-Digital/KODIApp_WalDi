import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.loading() = EditProfileStateLoading;

  const factory EditProfileState.loaded() = EditProfileStateLoaded;

  const factory EditProfileState.error() = EditProfileStateError;
}

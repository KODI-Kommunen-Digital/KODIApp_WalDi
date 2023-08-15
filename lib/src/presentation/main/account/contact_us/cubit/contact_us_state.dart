import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_us_state.freezed.dart';

@freezed
class ContactUsState with _$ContactUsState {
  const factory ContactUsState.loading() = ContactUsStateLoading;

  const factory ContactUsState.loaded() = ContactUsStateLoaded;

  const factory ContactUsState.error() = ContactUsStateError;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_state.freezed.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState.loading() = FaqStateLoading;

  const factory FaqState.loaded() = FaqStateLoaded;

  const factory FaqState.error() = FaqStateError;
}

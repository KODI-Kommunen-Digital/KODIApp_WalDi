import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_listing_state.freezed.dart';

@freezed
class AddListingState with _$AddListingState {
  const factory AddListingState.loading() = AddListingLoading;

  const factory AddListingState.loaded() = AddListingLoaded;

  const factory AddListingState.error(String error) = AddListingError;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = ProfileStateLoading;

  const factory ProfileState.loaded(List<ProductModel> userListings) =
      ProfileStateLoaded;

  const factory ProfileState.error(String error) = ProfileStateError;
}

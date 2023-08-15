import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/model/model_category.dart';

part 'discovery_state.freezed.dart';

@freezed
class DiscoveryState with _$DiscoveryState {
  const factory DiscoveryState.initial() = DiscoveryStateInitial;

  const factory DiscoveryState.loading() = DiscoveryStateLoading;

  const factory DiscoveryState.loaded(List<CategoryModel> list) =
      DiscoveryStateLoaded;

  const factory DiscoveryState.updated(
    List<CategoryModel> list,
  ) = DiscoveryStateUpdated;

  const factory DiscoveryState.error(String error) = DiscoveryStateError;
}

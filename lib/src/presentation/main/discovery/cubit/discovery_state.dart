import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovery_state.freezed.dart';

@freezed
class DiscoveryState with _$DiscoveryState {
  const factory DiscoveryState.initial() = DiscoveryStateInitial;

  const factory DiscoveryState.loading() = DiscoveryStateLoading;

  const factory DiscoveryState.loaded(int cityId) = DiscoveryStateLoaded;

  const factory DiscoveryState.error(String error) = DiscoveryStateError;
}

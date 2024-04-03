import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_state.freezed.dart';

@freezed
class TestState with _$TestState {
  const factory TestState.initial() = TestStateInitial;

  const factory TestState.loading() = TestStateLoading;

  const factory TestState.loaded(List<dynamic>? listings) = TestStateLoaded;

  const factory TestState.error(String error) = TestStateError;
}
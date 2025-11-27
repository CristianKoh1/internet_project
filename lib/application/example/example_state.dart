part of 'example_bloc.dart';

@freezed
abstract class ExampleState with _$ExampleState {
  const factory ExampleState.initial({
    @Default(false) bool loading,
  }) = _ExampleInitial;
}

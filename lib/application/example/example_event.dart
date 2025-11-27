part of 'example_bloc.dart';

@freezed
sealed class ExampleEvent with _$ExampleEvent {
  const factory ExampleEvent.login() = ExampleLogin;
}

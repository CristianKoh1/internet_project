import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';
part 'example_event.dart';
part 'example_state.dart';
part 'example_bloc.freezed.dart';

@injectable
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ILocalRepository localRepository;

  ExampleBloc(this.localRepository)
    : super(const ExampleState.initial()) {
    on<ExampleEvent>((event, emit) async {
      switch (event) {
        case ExampleLogin():
          break;
      }
    });
  }
}

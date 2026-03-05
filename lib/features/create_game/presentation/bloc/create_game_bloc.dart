import 'package:chronicle_app/features/create_game/domain/repository/create_game_repository.dart';
import 'package:chronicle_app/features/create_game/presentation/bloc/creat_game_state.dart';
import 'package:chronicle_app/features/create_game/presentation/bloc/creata_game_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  final CreateGameRepository createGameRepository;

  CreateGameBloc({
    required this.createGameRepository,
  }) : super(CreateGameState.initial());
}

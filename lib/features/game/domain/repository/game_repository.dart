import 'package:chronicle_app/core/failure/failure.dart';
import 'package:chronicle_app/core/model/either.dart';

typedef GameUpdateCallback = Function({
  required String name,
  required String gameCode,
  required int currentRound,
  required int rounds,
  required int votingTime,
  required int roundTime,
  required int? remainingTime,
  required int macParticipants,
});

abstract class GameRepository {
  Future<Either<Failure, void>> joinGame({required String gameId});
}

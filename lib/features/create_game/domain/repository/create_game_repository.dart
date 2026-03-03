import 'package:chronicle_app/core/failure/failure.dart';
import 'package:chronicle_app/core/model/either.dart';

abstract class CreateGameRepository {
  Future<Either<Failure, String>> createGame({
    required String title,
    required int rounds,
    required int roundDuration,
    required int votingDuration,
    required int maximumParticipants,
  });
}

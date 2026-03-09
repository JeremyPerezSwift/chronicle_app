import 'package:dio/dio.dart';

class CreateGameRemoteDatasource {
  final Dio dio;

  CreateGameRemoteDatasource({required this.dio});

  Future<String> createGame({
    required String title,
    required int rounds,
    required int roundDuration,
    required int votingDuration,
    required int maximumParticipants,
  }) async {
    var result = await dio.post('/games/create', data: {
      'name': title,
      'maxRounds': rounds,
      'roundTime': roundDuration,
      'voteTime': votingDuration,
      'maxPlayers': maximumParticipants,
    });

    return result.data['gameCode'];
  }
}

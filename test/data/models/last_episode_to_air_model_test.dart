import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tLastEpisodeToAirModel = LastEpisodeToAirModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1.0,
    voteCount: 1,
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  );

  const tLastEpisodeToAir = LastEpisodeToAir(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1.0,
    voteCount: 1,
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  );

  group('Last Episode To Air Model', () {
    test('should be a subclass of Last Episode To Air entity', () async {
      final result = tLastEpisodeToAirModel.toEntity();
      expect(result, tLastEpisodeToAir);
    });
  });
}

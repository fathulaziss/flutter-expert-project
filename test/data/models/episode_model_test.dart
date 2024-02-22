import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Episode Model', () {
    test('should be a subclass of Episode entity', () async {
      final result = tEpisodeModel.toEntity();
      expect(result, tEpisode);
    });
  });
}

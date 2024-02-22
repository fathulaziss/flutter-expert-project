import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  const tSeason = Season(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  group('Season Model', () {
    test('should be a subclass of Season entity', () async {
      final result = tSeasonModel.toEntity();
      expect(result, tSeason);
    });
  });
}

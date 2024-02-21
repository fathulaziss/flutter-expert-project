import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_series_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesEpisodes usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesEpisodes(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeason = 1;
  final tTvSeriesEpisodeList = <Episode>[];

  test('should get list of tv series episode from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesEpisodes(tId, tSeason))
        .thenAnswer((_) async => Right(tTvSeriesEpisodeList));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, Right(tTvSeriesEpisodeList));
  });
}

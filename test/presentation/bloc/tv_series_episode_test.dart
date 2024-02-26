import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_episodes.dart';
import 'package:ditonton/presentation/bloc/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_episode_test.mocks.dart';

@GenerateMocks([GetTvSeriesEpisodes])
void main() {
  late TvSeriesEpisodeBloc tvSeriesEpisodeBloc;
  late MockGetTvSeriesEpisodes mockGetTvSeriesEpisodes;

  setUp(() {
    mockGetTvSeriesEpisodes = MockGetTvSeriesEpisodes();
    tvSeriesEpisodeBloc =
        TvSeriesEpisodeBloc(getTvSeriesEpisodes: mockGetTvSeriesEpisodes);
  });

  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
    episodeRunTime: [30, 22],
    firstAirDate: "1996-07-22",
    genres: [
      Genre(id: 10763, name: "News"),
      Genre(id: 35, name: "Comedy"),
    ],
    homepage: "https://www.cc.com/shows/the-daily-show",
    id: 2224,
    inProduction: true,
    languages: ["en"],
    lastAirDate: "2024-02-15",
    lastEpisodeToAir: LastEpisodeToAir(
      id: 5101843,
      name: "February 15, 2024 - Cord Jefferson",
      overview:
          "Jordan Klepper covers a sex scandal in the Fulton County, GA, D.A.'s office, Grace Kuhlenschmidt swoons over adulterous presidents, and director Cord Jefferson discusses \"American Fiction.\"",
      voteAverage: 0,
      voteCount: 0,
      airDate: "2024-02-15",
      episodeNumber: 4,
      episodeType: "standard",
      productionCode: "",
      runtime: 24,
      seasonNumber: 29,
      showId: 2224,
      stillPath: "/xhZlEPRlG71Wo8gvz6fCzWmY7kE.jpg",
    ),
    name: "The Daily Show",
    numberOfEpisodes: 3887,
    numberOfSeasons: 29,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Daily Show",
    overview:
        "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
    popularity: 3092.914,
    posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
    seasons: [
      Season(
        airDate: "1999-12-15",
        episodeCount: 89,
        id: 6869,
        name: "Specials",
        overview: "",
        posterPath: "",
        seasonNumber: 0,
        voteAverage: 0,
      )
    ],
    voteAverage: 6.3,
    voteCount: 471,
  );

  group('Tv Series Episode BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesEpisodeBloc.state,
        const TvSeriesEpisodeInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesEpisodes.execute(
          tTvSeriesDetail.id,
          tTvSeriesDetail.numberOfSeasons,
        )).thenAnswer((_) async => const Right(testTvSeriesEpisodes));
        return tvSeriesEpisodeBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesEpisode(
          tvSeriesId: tTvSeriesDetail.id,
          tvSeriesSeason: tTvSeriesDetail.numberOfSeasons,
        ));
      },
      expect: () {
        return [
          const TvSeriesEpisodeLoading(state: RequestState.Loading),
          const TvSeriesEpisodeLoaded(
              episodes: testTvSeriesEpisodes, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesEpisodes.execute(
          tTvSeriesDetail.id,
          tTvSeriesDetail.numberOfSeasons,
        ));
      },
    );

    blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTvSeriesEpisodes.execute(
          tTvSeriesDetail.id,
          tTvSeriesDetail.numberOfSeasons,
        )).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesEpisodeBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesEpisode(
          tvSeriesId: tTvSeriesDetail.id,
          tvSeriesSeason: tTvSeriesDetail.numberOfSeasons,
        ));
      },
      expect: () {
        return [
          const TvSeriesEpisodeLoading(state: RequestState.Loading),
          const TvSeriesEpisodeError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesEpisodes.execute(
          tTvSeriesDetail.id,
          tTvSeriesDetail.numberOfSeasons,
        ));
      },
    );
  });
}

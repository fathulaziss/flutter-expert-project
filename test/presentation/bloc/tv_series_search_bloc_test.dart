import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(searchTvSeries: mockSearchTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/fFWdqlnBVNMLDneYUeQLFuPBq4Z.jpg",
    genreIds: const [16, 10759],
    id: 888,
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Spider-Man",
    overview:
        "Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.",
    popularity: 81.13,
    posterPath: "/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg",
    firstAirDate: "1994-11-19",
    name: "Spider-Man",
    voteAverage: 8.269,
    voteCount: 950,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];
  const tQuery = 'Spiderman';

  group('Tv Series Search BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesSearchBloc.state,
        const TvSeriesSearchInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesSearchBloc;
      },
      act: (bloc) {
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () {
        return [
          const TvSeriesSearchLoading(state: RequestState.Loading),
          TvSeriesSearchLoaded(
              tvSeries: tTvSeriesList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesSearchBloc;
      },
      act: (bloc) {
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () {
        return [
          const TvSeriesSearchLoading(state: RequestState.Loading),
          const TvSeriesSearchError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );
  });
}

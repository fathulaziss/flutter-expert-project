import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_watchlist/tv_series_list_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_watchlist_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesListWatchlistBloc tvSeriesListWatchlistBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    tvSeriesListWatchlistBloc = TvSeriesListWatchlistBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
  });

  group('Tv Series List Watchlist BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesListWatchlistBloc.state,
        const TvSeriesListWatchlistInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesListWatchlistBloc, TvSeriesListWatchlistState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesListWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesListWatchlist());
      },
      expect: () {
        return [
          const TvSeriesListWatchlistLoading(state: RequestState.Loading),
          TvSeriesListWatchlistLoaded(
            tvSeries: testTvSeriesList,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest<TvSeriesListWatchlistBloc, TvSeriesListWatchlistState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesListWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesListWatchlist());
      },
      expect: () {
        return [
          const TvSeriesListWatchlistLoading(state: RequestState.Loading),
          const TvSeriesListWatchlistError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });
}

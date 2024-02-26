import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTvSeries, RemoveWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;

  setUp(() {
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
    );
  });

  group('Tv Series Watchlist BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesWatchlistBloc.state,
        const TvSeriesWatchlistInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'Should emit [Loading, Loaded] when Save is gotten successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Save Successfully'));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(
            const SaveTvSeriesToWatchlist(tvSeriesDetail: testTvSeriesDetail));
      },
      expect: () {
        return [
          const TvSeriesWatchlistLoading(state: RequestState.Loading),
          const TvSeriesWatchlistLoaded(
              message: 'Save Successfully', state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'Should emit [Loading, Error] when Save is gotten unsuccessful',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(
            const SaveTvSeriesToWatchlist(tvSeriesDetail: testTvSeriesDetail));
      },
      expect: () {
        return [
          const TvSeriesWatchlistLoading(state: RequestState.Loading),
          const TvSeriesWatchlistError(
            message: 'Database Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'Should emit [Loading, Loaded] when Remove is gotten successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Remove Successfully'));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveTvSeriesToWatchlist(
            tvSeriesDetail: testTvSeriesDetail));
      },
      expect: () {
        return [
          const TvSeriesWatchlistLoading(state: RequestState.Loading),
          const TvSeriesWatchlistLoaded(
              message: 'Remove Successfully', state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'Should emit [Loading, Error] when Remove is gotten unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => const Left(DatabaseFailure('Database Failure')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveTvSeriesToWatchlist(
            tvSeriesDetail: testTvSeriesDetail));
      },
      expect: () {
        return [
          const TvSeriesWatchlistLoading(state: RequestState.Loading),
          const TvSeriesWatchlistError(
            message: 'Database Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });
}

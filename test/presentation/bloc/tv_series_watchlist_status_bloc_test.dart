import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status/tv_series_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvSeriesStatus])
void main() {
  late TvSeriesWatchlistStatusBloc tvSeriesWatchlistStatusBloc;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;

  setUp(() {
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    tvSeriesWatchlistStatusBloc = TvSeriesWatchlistStatusBloc(
      getWatchListTvSeriesStatus: mockGetWatchListTvSeriesStatus,
    );
  });

  group('Tv Series Watchlist Status BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesWatchlistStatusBloc.state,
        const TvSeriesWatchlistStatusInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'Should emit [Loading, Loaded] when data is exist on watchlist',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(1))
            .thenAnswer((_) async => true);
        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const CheckTvSeriesOnWatchlist(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesWatchlistStatusLoaded(
              isExistAtWatchlist: true, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchListTvSeriesStatus.execute(1));
      },
    );

    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'Should emit [Loading, Error] when data is not exist on watchlist',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(1))
            .thenAnswer((_) async => false);
        return tvSeriesWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const CheckTvSeriesOnWatchlist(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesWatchlistStatusLoaded(
            isExistAtWatchlist: false,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchListTvSeriesStatus.execute(1));
      },
    );
  });
}

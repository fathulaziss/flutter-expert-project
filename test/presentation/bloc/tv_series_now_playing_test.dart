import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
    );
  });

  group('Tv Series Now Playing BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesNowPlayingBloc.state,
        const TvSeriesNowPlayingInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesNowPlaying());
      },
      expect: () {
        return [
          const TvSeriesNowPlayingLoading(state: RequestState.Loading),
          TvSeriesNowPlayingLoaded(
            tvSeries: testTvSeriesList,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesNowPlaying());
      },
      expect: () {
        return [
          const TvSeriesNowPlayingLoading(state: RequestState.Loading),
          const TvSeriesNowPlayingError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });
}

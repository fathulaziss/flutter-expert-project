import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  group('Tv Series Top Rated BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesTopRatedBloc.state,
        const TvSeriesTopRatedInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesTopRated());
      },
      expect: () {
        return [
          const TvSeriesTopRatedLoading(state: RequestState.Loading),
          TvSeriesTopRatedLoaded(
              tvSeries: testTvSeriesList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesTopRated());
      },
      expect: () {
        return [
          const TvSeriesTopRatedLoading(state: RequestState.Loading),
          const TvSeriesTopRatedError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}

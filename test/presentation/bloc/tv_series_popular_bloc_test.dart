import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc =
        TvSeriesPopularBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  group('Tv Series Popular BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesPopularBloc.state,
        const TvSeriesPopularInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesPopularBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesPopular());
      },
      expect: () {
        return [
          const TvSeriesPopularLoading(state: RequestState.Loading),
          TvSeriesPopularLoaded(
              tvSeries: testTvSeriesList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesPopularBloc;
      },
      act: (bloc) {
        bloc.add(FetchTvSeriesPopular());
      },
      expect: () {
        return [
          const TvSeriesPopularLoading(state: RequestState.Loading),
          const TvSeriesPopularError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc = TvSeriesRecommendationBloc(
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
    );
  });

  group('Tv Series Recommendation BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesRecommendationBloc.state,
        const TvSeriesRecommendationInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) {
        bloc.add(const FetchTvSeriesRecommendation(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesRecommendationLoading(state: RequestState.Loading),
          TvSeriesRecommendationLoaded(
              tvSeries: testTvSeriesList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(1));
      },
    );

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) {
        bloc.add(const FetchTvSeriesRecommendation(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesRecommendationLoading(state: RequestState.Loading),
          const TvSeriesRecommendationError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(1));
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  group('Movie Recommendation BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieRecommendationBloc.state,
        const MovieRecommendationInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));
        return movieRecommendationBloc;
      },
      act: (bloc) {
        bloc.add(const FetchMovieRecommendation(movieId: 1));
      },
      expect: () {
        return [
          const MovieRecommendationLoading(state: RequestState.Loading),
          MovieRecommendationLoaded(
              movies: testMovieList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) {
        bloc.add(const FetchMovieRecommendation(movieId: 1));
      },
      expect: () {
        return [
          const MovieRecommendationLoading(state: RequestState.Loading),
          const MovieRecommendationError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );
  });
}

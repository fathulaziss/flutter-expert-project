import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  group('Movie Top Rated BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieTopRatedBloc.state,
        const MovieTopRatedInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieTopRated());
      },
      expect: () {
        return [
          const MovieTopRatedLoading(state: RequestState.Loading),
          MovieTopRatedLoaded(
              movies: testMovieList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieTopRated());
      },
      expect: () {
        return [
          const MovieTopRatedLoading(state: RequestState.Loading),
          const MovieTopRatedError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(getPopularMovies: mockGetPopularMovies);
  });

  group('Movie Popular BLoC', () {
    test('Initial state should be empty', () {
      expect(
        moviePopularBloc.state,
        const MoviePopularInitial(state: RequestState.Empty),
      );
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) {
        bloc.add(FetchMoviePopular());
      },
      expect: () {
        return [
          const MoviePopularLoading(state: RequestState.Loading),
          MoviePopularLoaded(movies: testMovieList, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) {
        bloc.add(FetchMoviePopular());
      },
      expect: () {
        return [
          const MoviePopularLoading(state: RequestState.Loading),
          const MoviePopularError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}

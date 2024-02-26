import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list_watchlist/movie_list_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_watchlist_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieListWatchlistBloc movieListWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieListWatchlistBloc = MovieListWatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group('Movie List Watchlist BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieListWatchlistBloc.state,
        const MovieListWatchlistInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieListWatchlistBloc, MovieListWatchlistState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieListWatchlist());
      },
      expect: () {
        return [
          const MovieListWatchlistLoading(state: RequestState.Loading),
          MovieListWatchlistLoaded(
            movies: testMovieList,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<MovieListWatchlistBloc, MovieListWatchlistState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieListWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieListWatchlist());
      },
      expect: () {
        return [
          const MovieListWatchlistLoading(state: RequestState.Loading),
          const MovieListWatchlistError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}

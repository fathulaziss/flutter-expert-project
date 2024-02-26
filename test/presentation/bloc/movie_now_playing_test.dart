import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
    );
  });

  group('Movie Now Playing BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieNowPlayingBloc.state,
        const MovieNowPlayingInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieNowPlaying());
      },
      expect: () {
        return [
          const MovieNowPlayingLoading(state: RequestState.Loading),
          MovieNowPlayingLoaded(
            movies: testMovieList,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) {
        bloc.add(FetchMovieNowPlaying());
      },
      expect: () {
        return [
          const MovieNowPlayingLoading(state: RequestState.Loading),
          const MovieNowPlayingError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}

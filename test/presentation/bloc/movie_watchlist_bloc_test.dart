import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;

  setUp(() {
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  group('Movie Watchlist BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieWatchlistBloc.state,
        const MovieWatchlistInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Loaded] when Save is gotten successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Save Successfully'));
        return movieWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const SaveMovieToWatchlist(movieDetail: testMovieDetail));
      },
      expect: () {
        return [
          const MovieWatchlistLoading(state: RequestState.Loading),
          const MovieWatchlistLoaded(
              message: 'Save Successfully', state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when Save is gotten unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const SaveMovieToWatchlist(movieDetail: testMovieDetail));
      },
      expect: () {
        return [
          const MovieWatchlistLoading(state: RequestState.Loading),
          const MovieWatchlistError(
            message: 'Database Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Loaded] when Remove is gotten successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Remove Successfully'));
        return movieWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveMovieToWatchlist(movieDetail: testMovieDetail));
      },
      expect: () {
        return [
          const MovieWatchlistLoading(state: RequestState.Loading),
          const MovieWatchlistLoaded(
              message: 'Remove Successfully', state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'Should emit [Loading, Error] when Remove is gotten unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) {
        bloc.add(const RemoveMovieToWatchlist(movieDetail: testMovieDetail));
      },
      expect: () {
        return [
          const MovieWatchlistLoading(state: RequestState.Loading),
          const MovieWatchlistError(
            message: 'Database Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}

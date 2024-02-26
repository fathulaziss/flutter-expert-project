import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late MovieWatchlistStatusBloc movieWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchlistStatusBloc = MovieWatchlistStatusBloc(
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  group('Movie Watchlist Status BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieWatchlistStatusBloc.state,
        const MovieWatchlistStatusInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [Loading, Loaded] when data is exist on watchlist',
      build: () {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return movieWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const CheckMovieOnWatchlist(movieId: 1));
      },
      expect: () {
        return [
          const MovieWatchlistStatusLoaded(
              isExistAtWatchlist: true, state: RequestState.Loaded),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(1));
      },
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [Loading, Error] when data is not exist on watchlist',
      build: () {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
        return movieWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(const CheckMovieOnWatchlist(movieId: 1));
      },
      expect: () {
        return [
          const MovieWatchlistStatusLoaded(
            isExistAtWatchlist: false,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(1));
      },
    );
  });
}

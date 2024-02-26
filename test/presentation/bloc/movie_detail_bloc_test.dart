import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  group('Movie Detail BLoC', () {
    test('Initial state should be empty', () {
      expect(
        movieDetailBloc.state,
        const MovieDetailInitial(state: RequestState.Empty),
      );
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) {
        bloc.add(const FetchMovieDetail(movieId: 1));
      },
      expect: () {
        return [
          const MovieDetailLoading(state: RequestState.Loading),
          const MovieDetailLoaded(
            movieDetail: testMovieDetail,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) {
        bloc.add(const FetchMovieDetail(movieId: 1));
      },
      expect: () {
        return [
          const MovieDetailLoading(state: RequestState.Loading),
          const MovieDetailError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
      },
    );
  });
}

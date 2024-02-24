import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedBloc({required this.getTopRatedMovies})
      : super(const MovieTopRatedInitial(state: RequestState.Empty)) {
    on<FetchMovieTopRated>((event, emit) async {
      emit(const MovieTopRatedLoading(state: RequestState.Loading));

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MovieTopRatedError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(MovieTopRatedLoaded(
            movies: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

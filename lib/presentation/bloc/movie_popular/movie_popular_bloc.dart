import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc({required this.getPopularMovies})
      : super(const MoviePopularInitial(state: RequestState.Empty)) {
    on<FetchMoviePopular>((event, emit) async {
      emit(const MoviePopularLoading(state: RequestState.Loading));

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviePopularError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(MoviePopularLoaded(
            movies: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

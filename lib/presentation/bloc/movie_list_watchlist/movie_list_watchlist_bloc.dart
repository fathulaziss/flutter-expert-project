import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_watchlist_event.dart';
part 'movie_list_watchlist_state.dart';

class MovieListWatchlistBloc
    extends Bloc<MovieListWatchlistEvent, MovieListWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieListWatchlistBloc({required this.getWatchlistMovies})
      : super(const MovieListWatchlistInitial(state: RequestState.Empty)) {
    on<FetchMovieListWatchlist>((event, emit) async {
      emit(const MovieListWatchlistLoading(state: RequestState.Loading));

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MovieListWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(MovieListWatchlistLoaded(
            movies: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

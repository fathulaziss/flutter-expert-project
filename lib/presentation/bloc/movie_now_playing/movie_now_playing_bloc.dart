import 'package:equatable/equatable.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc({required this.getNowPlayingMovies})
      : super(const MovieNowPlayingInitial(state: RequestState.Empty)) {
    on<FetchMovieNowPlaying>((event, emit) async {
      emit(const MovieNowPlayingLoading(state: RequestState.Loading));

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieNowPlayingError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(MovieNowPlayingLoaded(
            movies: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

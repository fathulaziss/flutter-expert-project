import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/utils/debounce_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies})
      : super(const MovieSearchInitial(state: RequestState.Empty)) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(const MovieSearchLoading(state: RequestState.Loading));

        final result = await searchMovies.execute(query);
        result.fold(
          (failure) {
            emit(MovieSearchError(
              message: failure.message,
              state: RequestState.Error,
            ));
          },
          (moviesData) {
            emit(MovieSearchLoaded(
              movies: moviesData,
              state: RequestState.Loaded,
            ));
          },
        );
      },
      transformer: DebonceTime.convert(const Duration(milliseconds: 500)),
    );
  }
}

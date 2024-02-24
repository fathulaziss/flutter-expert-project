import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;

  MovieWatchlistBloc({
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(const MovieWatchlistInitial(state: RequestState.Empty)) {
    on<SaveMovieToWatchlist>((event, emit) async {
      emit(const MovieWatchlistLoading(state: RequestState.Loading));

      final result = await saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (successMessage) {
          emit(MovieWatchlistLoaded(
            message: successMessage,
            state: RequestState.Loaded,
          ));
        },
      );
    });

    on<RemoveMovieToWatchlist>((event, emit) async {
      emit(const MovieWatchlistLoading(state: RequestState.Loading));

      final result = await removeWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (successMessage) {
          emit(MovieWatchlistLoaded(
            message: successMessage,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

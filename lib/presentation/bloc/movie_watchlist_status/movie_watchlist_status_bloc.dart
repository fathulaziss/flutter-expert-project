import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;

  MovieWatchlistStatusBloc({required this.getWatchListStatus})
      : super(const MovieWatchlistStatusInitial(state: RequestState.Empty)) {
    on<CheckMovieOnWatchlist>((event, emit) async {
      final result = await getWatchListStatus.execute(event.movieId);

      emit(MovieWatchlistStatusLoaded(
        state: RequestState.Loaded,
        isExistAtWatchlist: result,
      ));
    });
  }
}

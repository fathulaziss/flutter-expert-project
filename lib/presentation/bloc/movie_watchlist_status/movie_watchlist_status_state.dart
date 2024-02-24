part of 'movie_watchlist_status_bloc.dart';

class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {
  final RequestState state;

  const MovieWatchlistStatusInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieWatchlistStatusLoading extends MovieWatchlistStatusState {
  final RequestState state;

  const MovieWatchlistStatusLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieWatchlistStatusLoaded extends MovieWatchlistStatusState {
  final bool isExistAtWatchlist;
  final RequestState state;

  const MovieWatchlistStatusLoaded({
    this.isExistAtWatchlist = false,
    required this.state,
  });

  @override
  List<Object> get props => [isExistAtWatchlist, state];
}

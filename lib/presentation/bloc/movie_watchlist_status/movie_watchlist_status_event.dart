part of 'movie_watchlist_status_bloc.dart';

class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckMovieOnWatchlist extends MovieWatchlistStatusEvent {
  final int movieId;

  const CheckMovieOnWatchlist({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

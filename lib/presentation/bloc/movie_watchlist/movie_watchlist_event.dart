part of 'movie_watchlist_bloc.dart';

class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class SaveMovieToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const SaveMovieToWatchlist({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const RemoveMovieToWatchlist({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

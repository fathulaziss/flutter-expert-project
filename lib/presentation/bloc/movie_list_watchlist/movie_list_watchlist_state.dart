part of 'movie_list_watchlist_bloc.dart';

class MovieListWatchlistState extends Equatable {
  const MovieListWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieListWatchlistInitial extends MovieListWatchlistState {
  final RequestState state;

  const MovieListWatchlistInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieListWatchlistLoading extends MovieListWatchlistState {
  final RequestState state;

  const MovieListWatchlistLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieListWatchlistLoaded extends MovieListWatchlistState {
  final List<Movie> movies;
  final RequestState state;

  const MovieListWatchlistLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MovieListWatchlistError extends MovieListWatchlistState {
  final String message;
  final RequestState state;

  const MovieListWatchlistError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

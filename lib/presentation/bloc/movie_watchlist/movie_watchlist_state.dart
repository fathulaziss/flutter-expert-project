part of 'movie_watchlist_bloc.dart';

class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {
  final RequestState state;

  const MovieWatchlistInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieWatchlistLoading extends MovieWatchlistState {
  final RequestState state;

  const MovieWatchlistLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final String message;
  final RequestState state;

  const MovieWatchlistLoaded({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;
  final RequestState state;

  const MovieWatchlistError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

part of 'movie_now_playing_bloc.dart';

class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {
  final RequestState state;

  const MovieNowPlayingInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieNowPlayingLoading extends MovieNowPlayingState {
  final RequestState state;

  const MovieNowPlayingLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;
  final RequestState state;

  const MovieNowPlayingLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;
  final RequestState state;

  const MovieNowPlayingError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

part of 'movie_top_rated_bloc.dart';

class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedInitial extends MovieTopRatedState {
  final RequestState state;

  const MovieTopRatedInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieTopRatedLoading extends MovieTopRatedState {
  final RequestState state;

  const MovieTopRatedLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> movies;
  final RequestState state;

  const MovieTopRatedLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;
  final RequestState state;

  const MovieTopRatedError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

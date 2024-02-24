part of 'movie_popular_bloc.dart';

class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularInitial extends MoviePopularState {
  final RequestState state;

  const MoviePopularInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MoviePopularLoading extends MoviePopularState {
  final RequestState state;

  const MoviePopularLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MoviePopularLoaded extends MoviePopularState {
  final List<Movie> movies;
  final RequestState state;

  const MoviePopularLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MoviePopularError extends MoviePopularState {
  final String message;
  final RequestState state;

  const MoviePopularError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

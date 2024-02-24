part of 'movie_search_bloc.dart';

class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {
  final RequestState state;

  const MovieSearchInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieSearchLoading extends MovieSearchState {
  final RequestState state;

  const MovieSearchLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;
  final RequestState state;

  const MovieSearchLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MovieSearchError extends MovieSearchState {
  final String message;
  final RequestState state;

  const MovieSearchError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

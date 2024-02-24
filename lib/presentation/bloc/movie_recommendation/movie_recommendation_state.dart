part of 'movie_recommendation_bloc.dart';

class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationInitial extends MovieRecommendationState {
  final RequestState state;

  const MovieRecommendationInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieRecommendationLoading extends MovieRecommendationState {
  final RequestState state;

  const MovieRecommendationLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;
  final RequestState state;

  const MovieRecommendationLoaded({required this.movies, required this.state});

  @override
  List<Object> get props => [movies, state];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;
  final RequestState state;

  const MovieRecommendationError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

part of 'movie_recommendation_bloc.dart';

class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieRecommendationEvent {
  final int movieId;

  const FetchMovieRecommendation({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

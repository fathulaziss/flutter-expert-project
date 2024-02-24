part of 'tv_series_recommendation_bloc.dart';

class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {
  final RequestState state;

  const TvSeriesRecommendationInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {
  final RequestState state;

  const TvSeriesRecommendationLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesRecommendationLoaded({
    required this.tvSeries,
    required this.state,
  });

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;
  final RequestState state;

  const TvSeriesRecommendationError(
      {required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

part of 'tv_series_popular_bloc.dart';

class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularInitial extends TvSeriesPopularState {
  final RequestState state;

  const TvSeriesPopularInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesPopularLoading extends TvSeriesPopularState {
  final RequestState state;

  const TvSeriesPopularLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesPopularLoaded extends TvSeriesPopularState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesPopularLoaded({required this.tvSeries, required this.state});

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;
  final RequestState state;

  const TvSeriesPopularError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

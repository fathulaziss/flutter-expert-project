part of 'tv_series_top_rated_bloc.dart';

class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedInitial extends TvSeriesTopRatedState {
  final RequestState state;

  const TvSeriesTopRatedInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {
  final RequestState state;

  const TvSeriesTopRatedLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesTopRatedLoaded extends TvSeriesTopRatedState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesTopRatedLoaded({required this.tvSeries, required this.state});

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;
  final RequestState state;

  const TvSeriesTopRatedError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

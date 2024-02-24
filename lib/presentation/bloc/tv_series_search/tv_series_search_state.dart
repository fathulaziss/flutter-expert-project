part of 'tv_series_search_bloc.dart';

class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchInitial extends TvSeriesSearchState {
  final RequestState state;

  const TvSeriesSearchInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesSearchLoading extends TvSeriesSearchState {
  final RequestState state;

  const TvSeriesSearchLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesSearchLoaded({required this.tvSeries, required this.state});

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesSearchError extends TvSeriesSearchState {
  final String message;
  final RequestState state;

  const TvSeriesSearchError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

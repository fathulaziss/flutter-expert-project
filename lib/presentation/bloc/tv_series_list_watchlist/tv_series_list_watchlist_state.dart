part of 'tv_series_list_watchlist_bloc.dart';

class TvSeriesListWatchlistState extends Equatable {
  const TvSeriesListWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesListWatchlistInitial extends TvSeriesListWatchlistState {
  final RequestState state;

  const TvSeriesListWatchlistInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesListWatchlistLoading extends TvSeriesListWatchlistState {
  final RequestState state;

  const TvSeriesListWatchlistLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesListWatchlistLoaded extends TvSeriesListWatchlistState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesListWatchlistLoaded({
    required this.tvSeries,
    required this.state,
  });

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesListWatchlistError extends TvSeriesListWatchlistState {
  final String message;
  final RequestState state;

  const TvSeriesListWatchlistError(
      {required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

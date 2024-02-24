part of 'tv_series_watchlist_bloc.dart';

class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {
  final RequestState state;

  const TvSeriesWatchlistInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {
  final RequestState state;

  const TvSeriesWatchlistLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final String message;
  final RequestState state;

  const TvSeriesWatchlistLoaded({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;
  final RequestState state;

  const TvSeriesWatchlistError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

part of 'tv_series_list_watchlist_bloc.dart';

sealed class TvSeriesListWatchlistEvent extends Equatable {
  const TvSeriesListWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesListWatchlist extends TvSeriesListWatchlistEvent {}

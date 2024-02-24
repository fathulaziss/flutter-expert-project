part of 'tv_series_watchlist_bloc.dart';

class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class SaveTvSeriesToWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const SaveTvSeriesToWatchlist({required this.tvSeriesDetail});

  @override
  List<Object> get props => [TvSeriesDetail];
}

class RemoveTvSeriesToWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesToWatchlist({required this.tvSeriesDetail});

  @override
  List<Object> get props => [TvSeriesDetail];
}

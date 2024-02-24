part of 'tv_series_watchlist_status_bloc.dart';

class TvSeriesWatchlistStatusEvent extends Equatable {
  const TvSeriesWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckTvSeriesOnWatchlist extends TvSeriesWatchlistStatusEvent {
  final int tvSeriesId;

  const CheckTvSeriesOnWatchlist({required this.tvSeriesId});

  @override
  List<Object> get props => [tvSeriesId];
}

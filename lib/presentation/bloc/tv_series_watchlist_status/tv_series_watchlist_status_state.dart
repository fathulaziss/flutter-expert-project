part of 'tv_series_watchlist_status_bloc.dart';

class TvSeriesWatchlistStatusState extends Equatable {
  const TvSeriesWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistStatusInitial extends TvSeriesWatchlistStatusState {
  final RequestState state;

  const TvSeriesWatchlistStatusInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesWatchlistStatusLoading extends TvSeriesWatchlistStatusState {
  final RequestState state;

  const TvSeriesWatchlistStatusLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesWatchlistStatusLoaded extends TvSeriesWatchlistStatusState {
  final bool isExistAtWatchlist;
  final RequestState state;

  const TvSeriesWatchlistStatusLoaded({
    this.isExistAtWatchlist = false,
    required this.state,
  });

  @override
  List<Object> get props => [isExistAtWatchlist, state];
}

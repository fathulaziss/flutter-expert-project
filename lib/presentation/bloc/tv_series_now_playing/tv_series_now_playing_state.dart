part of 'tv_series_now_playing_bloc.dart';

class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingInitial extends TvSeriesNowPlayingState {
  final RequestState state;

  const TvSeriesNowPlayingInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {
  final RequestState state;

  const TvSeriesNowPlayingLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesNowPlayingLoaded extends TvSeriesNowPlayingState {
  final List<TvSeries> tvSeries;
  final RequestState state;

  const TvSeriesNowPlayingLoaded({
    required this.tvSeries,
    required this.state,
  });

  @override
  List<Object> get props => [tvSeries, state];
}

class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;
  final RequestState state;

  const TvSeriesNowPlayingError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

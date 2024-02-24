part of 'tv_series_episode_bloc.dart';

class TvSeriesEpisodeState extends Equatable {
  const TvSeriesEpisodeState();

  @override
  List<Object> get props => [];
}

class TvSeriesEpisodeInitial extends TvSeriesEpisodeState {
  final RequestState state;

  const TvSeriesEpisodeInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesEpisodeLoading extends TvSeriesEpisodeState {
  final RequestState state;

  const TvSeriesEpisodeLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesEpisodeLoaded extends TvSeriesEpisodeState {
  final List<Episode> episodes;
  final RequestState state;

  const TvSeriesEpisodeLoaded({required this.episodes, required this.state});

  @override
  List<Object> get props => [episodes, state];
}

class TvSeriesEpisodeError extends TvSeriesEpisodeState {
  final String message;
  final RequestState state;

  const TvSeriesEpisodeError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

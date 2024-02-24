part of 'tv_series_episode_bloc.dart';

class TvSeriesEpisodeEvent extends Equatable {
  const TvSeriesEpisodeEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesEpisode extends TvSeriesEpisodeEvent {
  final int tvSeriesId;
  final int tvSeriesSeason;

  const FetchTvSeriesEpisode({
    required this.tvSeriesId,
    required this.tvSeriesSeason,
  });

  @override
  List<Object> get props => [tvSeriesId];
}

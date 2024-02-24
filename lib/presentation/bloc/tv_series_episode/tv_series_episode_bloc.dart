import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_series_episodes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_episode_event.dart';
part 'tv_series_episode_state.dart';

class TvSeriesEpisodeBloc
    extends Bloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState> {
  final GetTvSeriesEpisodes getTvSeriesEpisodes;

  TvSeriesEpisodeBloc({required this.getTvSeriesEpisodes})
      : super(const TvSeriesEpisodeInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesEpisode>((event, emit) async {
      emit(const TvSeriesEpisodeLoading(state: RequestState.Loading));

      final result = await getTvSeriesEpisodes.execute(
        event.tvSeriesId,
        event.tvSeriesSeason,
      );

      result.fold(
        (failure) {
          emit(TvSeriesEpisodeError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (episodesData) {
          emit(TvSeriesEpisodeLoaded(
            episodes: episodesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

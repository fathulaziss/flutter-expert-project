import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  TvSeriesNowPlayingBloc({required this.getNowPlayingTvSeries})
      : super(const TvSeriesNowPlayingInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesNowPlaying>((event, emit) async {
      emit(const TvSeriesNowPlayingLoading(state: RequestState.Loading));

      final result = await getNowPlayingTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesNowPlayingError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (tvSeriesData) {
          emit(TvSeriesNowPlayingLoaded(
            tvSeries: tvSeriesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

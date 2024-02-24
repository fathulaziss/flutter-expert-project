import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesTopRatedBloc({required this.getTopRatedTvSeries})
      : super(const TvSeriesTopRatedInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesTopRated>((event, emit) async {
      emit(const TvSeriesTopRatedLoading(state: RequestState.Loading));

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesTopRatedError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (tvSeriesData) {
          emit(TvSeriesTopRatedLoaded(
            tvSeries: tvSeriesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

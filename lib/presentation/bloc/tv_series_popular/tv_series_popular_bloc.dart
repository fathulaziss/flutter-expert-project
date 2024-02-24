import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularBloc({required this.getPopularTvSeries})
      : super(const TvSeriesPopularInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesPopular>((event, emit) async {
      emit(const TvSeriesPopularLoading(state: RequestState.Loading));

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesPopularError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (tvSeriesData) {
          emit(TvSeriesPopularLoaded(
            tvSeries: tvSeriesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

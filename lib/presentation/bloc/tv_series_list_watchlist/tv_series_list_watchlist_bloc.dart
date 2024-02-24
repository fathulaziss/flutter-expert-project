import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_list_watchlist_event.dart';
part 'tv_series_list_watchlist_state.dart';

class TvSeriesListWatchlistBloc
    extends Bloc<TvSeriesListWatchlistEvent, TvSeriesListWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  TvSeriesListWatchlistBloc({required this.getWatchlistTvSeries})
      : super(const TvSeriesListWatchlistInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesListWatchlist>((event, emit) async {
      emit(const TvSeriesListWatchlistLoading(state: RequestState.Loading));

      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesListWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (tvSeriesData) {
          emit(TvSeriesListWatchlistLoaded(
            tvSeries: tvSeriesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;

  TvSeriesWatchlistBloc({
    required this.removeWatchlistTvSeries,
    required this.saveWatchlistTvSeries,
  }) : super(const TvSeriesWatchlistInitial(state: RequestState.Empty)) {
    on<SaveTvSeriesToWatchlist>((event, emit) async {
      emit(const TvSeriesWatchlistLoading(state: RequestState.Loading));

      final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);

      result.fold(
        (failure) {
          emit(TvSeriesWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (successMessage) {
          emit(TvSeriesWatchlistLoaded(
            message: successMessage,
            state: RequestState.Loaded,
          ));
        },
      );
    });

    on<RemoveTvSeriesToWatchlist>((event, emit) async {
      emit(const TvSeriesWatchlistLoading(state: RequestState.Loading));

      final result = await removeWatchlistTvSeries.execute(
        event.tvSeriesDetail,
      );

      result.fold(
        (failure) {
          emit(TvSeriesWatchlistError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (successMessage) {
          emit(TvSeriesWatchlistLoaded(
            message: successMessage,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

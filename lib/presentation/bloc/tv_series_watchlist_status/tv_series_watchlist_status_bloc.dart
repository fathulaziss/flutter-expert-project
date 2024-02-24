import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_watchlist_status_event.dart';
part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusBloc
    extends Bloc<TvSeriesWatchlistStatusEvent, TvSeriesWatchlistStatusState> {
  final GetWatchListTvSeriesStatus getWatchListTvSeriesStatus;

  TvSeriesWatchlistStatusBloc({required this.getWatchListTvSeriesStatus})
      : super(const TvSeriesWatchlistStatusInitial(state: RequestState.Empty)) {
    on<CheckTvSeriesOnWatchlist>((event, emit) async {
      final result = await getWatchListTvSeriesStatus.execute(event.tvSeriesId);

      emit(TvSeriesWatchlistStatusLoaded(
        state: RequestState.Loaded,
        isExistAtWatchlist: result,
      ));
    });
  }
}

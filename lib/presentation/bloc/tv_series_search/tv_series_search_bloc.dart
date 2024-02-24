import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/utils/debounce_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc({required this.searchTvSeries})
      : super(const TvSeriesSearchInitial(state: RequestState.Empty)) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(const TvSeriesSearchLoading(state: RequestState.Loading));

        final result = await searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(TvSeriesSearchError(
              message: failure.message,
              state: RequestState.Error,
            ));
          },
          (tvSeriesData) {
            emit(TvSeriesSearchLoaded(
              tvSeries: tvSeriesData,
              state: RequestState.Loaded,
            ));
          },
        );
      },
      transformer: DebonceTime.convert(const Duration(milliseconds: 500)),
    );
  }
}

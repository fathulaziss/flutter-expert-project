import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_enum.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailBloc({required this.getTvSeriesDetail})
      : super(const TvSeriesDetailInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(const TvSeriesDetailLoading(state: RequestState.Loading));

      final result = await getTvSeriesDetail.execute(event.tvSeriesId);

      result.fold(
        (failure) {
          emit(TvSeriesDetailError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (tvSeriesData) {
          emit(TvSeriesDetailLoaded(
            tvSeriesDetail: tvSeriesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

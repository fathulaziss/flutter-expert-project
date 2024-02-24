import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationBloc({required this.getTvSeriesRecommendations})
      : super(const TvSeriesRecommendationInitial(state: RequestState.Empty)) {
    on<FetchTvSeriesRecommendation>((event, emit) async {
      emit(const TvSeriesRecommendationLoading(state: RequestState.Loading));

      final result = await getTvSeriesRecommendations.execute(event.tvSeriesId);

      result.fold(
        (failure) {
          emit(TvSeriesRecommendationError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(TvSeriesRecommendationLoaded(
            tvSeries: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

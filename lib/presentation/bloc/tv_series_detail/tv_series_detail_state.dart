part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {
  final RequestState state;

  const TvSeriesDetailInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesDetailLoading extends TvSeriesDetailState {
  final RequestState state;

  const TvSeriesDetailLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;
  final RequestState state;

  const TvSeriesDetailLoaded({
    required this.tvSeriesDetail,
    required this.state,
  });

  @override
  List<Object> get props => [TvSeriesDetail, state];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;
  final RequestState state;

  const TvSeriesDetailError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

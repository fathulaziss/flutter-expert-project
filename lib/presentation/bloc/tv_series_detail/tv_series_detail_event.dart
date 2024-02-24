part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int tvSeriesId;

  const FetchTvSeriesDetail({required this.tvSeriesId});

  @override
  List<Object> get props => [tvSeriesId];
}

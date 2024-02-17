import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListTvSeriesStatus getWatchListTvSeriesStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListTvSeriesStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  });

  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesDetailState = RequestState.Empty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationTvSeriesState = RequestState.Empty;
  RequestState get recommendationTvSeriesState => _recommendationTvSeriesState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTvSeries = false;
  bool get isAddedToWatchlistTvSeries => _isAddedtoWatchlistTvSeries;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesDetail) {
        _recommendationTvSeriesState = RequestState.Loading;
        _tvSeriesDetail = tvSeriesDetail;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationTvSeriesState = RequestState.Error;
            _message = failure.message;
          },
          (tvSeriesRecommendations) {
            _recommendationTvSeriesState = RequestState.Loaded;
            _tvSeriesRecommendations = tvSeriesRecommendations;
          },
        );
        _tvSeriesDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistTvSeries(TvSeriesDetail tvSeriesDetail) async {
    final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistTvSeriesStatus(tvSeriesDetail.id);
  }

  Future<void> removeFromWatchlistTvSeries(
      TvSeriesDetail tvSeriesDetail) async {
    final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistTvSeriesStatus(tvSeriesDetail.id);
  }

  Future<void> loadWatchlistTvSeriesStatus(int id) async {
    final result = await getWatchListTvSeriesStatus.execute(id);
    _isAddedtoWatchlistTvSeries = result;
    notifyListeners();
  }
}

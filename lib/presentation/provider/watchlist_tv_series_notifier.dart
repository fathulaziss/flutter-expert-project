import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  WatchlistTvSeriesNotifier(this.getWatchlistTvSeries);

  final GetWatchlistTvSeries getWatchlistTvSeries;

  RequestState _watchlistTvSeriesState = RequestState.Empty;
  RequestState get watchlistTvSeriesState => _watchlistTvSeriesState;

  List<TvSeries> _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvSeriesState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}

// ignore_for_file: constant_identifier_names

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Movies', style: kHeading6),
              Consumer<WatchlistMovieNotifier>(builder: (context, data, child) {
                final state = data.watchlistState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  if (data.watchlistMovies.isNotEmpty) {
                    return MovieList(data.watchlistMovies);
                  } else {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Anda belum menambahkan Movie ke daftar tonton Anda',
                          textAlign: TextAlign.center,
                          style: kBodyText,
                        ),
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        key: const Key('error_message'),
                        data.message,
                        textAlign: TextAlign.center,
                        style: kBodyText,
                      ),
                    ),
                  );
                }
              }),
              Text('Tv Series', style: kHeading6),
              Consumer<WatchlistTvSeriesNotifier>(
                  builder: (context, data, child) {
                final state = data.watchlistTvSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  if (data.watchlistTvSeries.isNotEmpty) {
                    return TvSeriesList(data.watchlistTvSeries);
                  } else {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Anda belum menambahkan Tv Series ke daftar tonton Anda',
                          textAlign: TextAlign.center,
                          style: kBodyText,
                        ),
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        key: const Key('error_message'),
                        data.message,
                        textAlign: TextAlign.center,
                        style: kBodyText,
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

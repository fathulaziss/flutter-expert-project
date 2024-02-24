// ignore_for_file: constant_identifier_names

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_list_watchlist/movie_list_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_watchlist/tv_series_list_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieListWatchlistBloc>().add(FetchMovieListWatchlist());
      context
          .read<TvSeriesListWatchlistBloc>()
          .add(FetchTvSeriesListWatchlist());
    });
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
              BlocBuilder<MovieListWatchlistBloc, MovieListWatchlistState>(
                builder: (context, state) {
                  if (state is MovieListWatchlistLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieListWatchlistLoaded) {
                    final movies = state.movies;
                    if (movies.isNotEmpty) {
                      return MovieList(movies);
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
                  } else if (state is MovieListWatchlistError) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          key: const Key('error_message'),
                          state.message,
                          textAlign: TextAlign.center,
                          style: kBodyText,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Text('Tv Series', style: kHeading6),
              BlocBuilder<TvSeriesListWatchlistBloc,
                  TvSeriesListWatchlistState>(
                builder: (context, state) {
                  if (state is TvSeriesListWatchlistLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TvSeriesListWatchlistLoaded) {
                    final tvSeries = state.tvSeries;
                    if (tvSeries.isNotEmpty) {
                      return TvSeriesList(tvSeries);
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
                  } else if (state is TvSeriesListWatchlistError) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          key: const Key('error_message'),
                          state.message,
                          textAlign: TextAlign.center,
                          style: kBodyText,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

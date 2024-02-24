// ignore_for_file: constant_identifier_names

import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-list';

  const TvSeriesListPage({super.key});

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesNowPlayingBloc>().add(FetchTvSeriesNowPlaying());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
          builder: (context, state) {
            if (state is TvSeriesNowPlayingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvSeriesNowPlayingLoaded) {
              final tvSeriesList = state.tvSeries;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: tvSeriesList.length,
              );
            } else if (state is TvSeriesNowPlayingError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

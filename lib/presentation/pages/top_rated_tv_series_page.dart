// ignore_for_file: constant_identifier_names

import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<TopRatedTvSeriesNotifier>(context, listen: false)
    //         .fetchTopRatedTvSeries());
    Future.microtask(() {
      context.read<TvSeriesTopRatedBloc>().add(FetchTvSeriesTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvSeriesTopRatedLoaded) {
              final tvSeriesList = state.tvSeries;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: tvSeriesList.length,
              );
            } else if (state is TvSeriesTopRatedError) {
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

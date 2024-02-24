// ignore_for_file: constant_identifier_names

import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<PopularTvSeriesNotifier>(context, listen: false)
    //         .fetchPopularTvSeries());
    Future.microtask(() {
      context.read<TvSeriesPopularBloc>().add(FetchTvSeriesPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Consumer<PopularTvSeriesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tvSeries = data.tvSeries[index];
        //           return TvSeriesCard(tvSeries);
        //         },
        //         itemCount: data.tvSeries.length,
        //       );
        //     } else {
        //       return Center(
        //         key: const Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvSeriesPopularLoaded) {
              final tvSeriesList = state.tvSeries;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: tvSeriesList.length,
              );
            } else if (state is TvSeriesPopularError) {
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

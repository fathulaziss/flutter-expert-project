import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_list_page.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesScreen extends StatefulWidget {
  const TvSeriesScreen({super.key});

  @override
  State<TvSeriesScreen> createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //     () => Provider.of<TvSeriesListNotifier>(context, listen: false)
    //       ..fetchNowPlayingTvSeries()
    //       ..fetchPopularTvSeries()
    //       ..fetchTopRatedTvSeries());
    Future.microtask(() {
      context.read<TvSeriesNowPlayingBloc>().add(FetchTvSeriesNowPlaying());
      context.read<TvSeriesPopularBloc>().add(FetchTvSeriesPopular());
      context.read<TvSeriesTopRatedBloc>().add(FetchTvSeriesTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airing Today',
              onTap: () =>
                  Navigator.pushNamed(context, TvSeriesListPage.ROUTE_NAME),
            ),
            // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
            //   final state = data.nowPlayingTvSeriesState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return TvSeriesList(data.nowPlayingTvSeries);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
              builder: (context, state) {
                if (state is TvSeriesNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesNowPlayingLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
            ),
            // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
            //   final state = data.popularTvSeriesState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return TvSeriesList(data.popularTvSeries);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
              builder: (context, state) {
                if (state is TvSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesPopularLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
            ),
            // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
            //   final state = data.topRatedTvSeriesState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return TvSeriesList(data.topRatedTvSeries);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
              builder: (context, state) {
                if (state is TvSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesTopRatedLoaded) {
                  return TvSeriesList(state.tvSeries);
                } else {
                  return const Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

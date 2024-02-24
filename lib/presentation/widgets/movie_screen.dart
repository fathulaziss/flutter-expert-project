import 'package:ditonton/common/constants.dart';

import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //     () => Provider.of<MovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies());
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(FetchMovieNowPlaying());
      context.read<MoviePopularBloc>().add(FetchMoviePopular());
      context.read<MovieTopRatedBloc>().add(FetchMovieTopRated());
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
            Text('Now Playing', style: kHeading6),
            // Consumer<MovieListNotifier>(builder: (context, data, child) {
            //   final state = data.nowPlayingState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return MovieList(data.nowPlayingMovies);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
              builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieNowPlayingLoaded) {
                  return MovieList(state.movies);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            // Consumer<MovieListNotifier>(builder: (context, data, child) {
            //   final state = data.popularMoviesState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return MovieList(data.popularMovies);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<MoviePopularBloc, MoviePopularState>(
              builder: (context, state) {
                if (state is MoviePopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviePopularLoaded) {
                  return MovieList(state.movies);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            // Consumer<MovieListNotifier>(builder: (context, data, child) {
            //   final state = data.topRatedMoviesState;
            //   if (state == RequestState.Loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   } else if (state == RequestState.Loaded) {
            //     return MovieList(data.topRatedMovies);
            //   } else {
            //     return const Text('Failed');
            //   }
            // }),
            BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
              builder: (context, state) {
                if (state is MovieTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieTopRatedLoaded) {
                  return MovieList(state.movies);
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

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/screen_enum.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_now_playing/tv_series_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_list_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  ScreenType screenType = ScreenType.Movie;

  @override
  void initState() {
    initDataMovies();
    super.initState();
  }

  Future<void> initDataMovies() async {
    await Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(FetchMovieNowPlaying());
      context.read<MoviePopularBloc>().add(FetchMoviePopular());
      context.read<MovieTopRatedBloc>().add(FetchMovieTopRated());
    });
  }

  Future<void> initDataTvSeries() async {
    Future.microtask(() {
      context.read<TvSeriesNowPlayingBloc>().add(FetchTvSeriesNowPlaying());
      context.read<TvSeriesPopularBloc>().add(FetchTvSeriesPopular());
      context.read<TvSeriesTopRatedBloc>().add(FetchTvSeriesTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                setState(() {
                  screenType = ScreenType.Movie;
                });
                initDataMovies();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('TV Series'),
              onTap: () {
                setState(() {
                  screenType = ScreenType.TvSeries;
                });
                initDataTvSeries();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              if (screenType == ScreenType.Movie) {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (screenType == ScreenType.Movie)
                Text('Now Playing', style: kHeading6)
              else
                _buildSubHeading(
                  title: 'Airing Today',
                  onTap: () {
                    Navigator.pushNamed(context, TvSeriesListPage.ROUTE_NAME);
                  },
                ),
              if (screenType == ScreenType.Movie)
                BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieNowPlayingLoaded) {
                      return MovieList(state.movies);
                    } else if (state is MovieNowPlayingError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              else
                BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
                  builder: (context, state) {
                    if (state is TvSeriesNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvSeriesNowPlayingLoaded) {
                      return TvSeriesList(state.tvSeries);
                    } else if (state is TvSeriesNowPlayingError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  if (screenType == ScreenType.Movie) {
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                  } else {
                    Navigator.pushNamed(
                        context, PopularTvSeriesPage.ROUTE_NAME);
                  }
                },
              ),
              if (screenType == ScreenType.Movie)
                BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                    if (state is MoviePopularLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MoviePopularLoaded) {
                      return MovieList(state.movies);
                    } else if (state is MoviePopularError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              else
                BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                  builder: (context, state) {
                    if (state is TvSeriesPopularLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvSeriesPopularLoaded) {
                      return TvSeriesList(state.tvSeries);
                    } else if (state is TvSeriesPopularError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  if (screenType == ScreenType.Movie) {
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                  } else {
                    Navigator.pushNamed(
                        context, TopRatedTvSeriesPage.ROUTE_NAME);
                  }
                },
              ),
              if (screenType == ScreenType.Movie)
                BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                    if (state is MovieTopRatedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieTopRatedLoaded) {
                      return MovieList(state.movies);
                    } else if (state is MovieTopRatedError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              else
                BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                  builder: (context, state) {
                    if (state is TvSeriesTopRatedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvSeriesTopRatedLoaded) {
                      return TvSeriesList(state.tvSeries);
                    } else if (state is TvSeriesTopRatedError) {
                      return Text(state.message);
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

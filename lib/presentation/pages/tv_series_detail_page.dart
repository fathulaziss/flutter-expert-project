// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status/tv_series_watchlist_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<TvSeriesDetailBloc>()
          .add(FetchTvSeriesDetail(tvSeriesId: widget.id));
      context
          .read<TvSeriesWatchlistStatusBloc>()
          .add(CheckTvSeriesOnWatchlist(tvSeriesId: widget.id));
      context
          .read<TvSeriesRecommendationBloc>()
          .add(FetchTvSeriesRecommendation(tvSeriesId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvSeriesDetailLoaded) {
            final tvSeriesDetail = state.tvSeriesDetail;
            context.read<TvSeriesEpisodeBloc>().add(FetchTvSeriesEpisode(
                  tvSeriesId: tvSeriesDetail.id,
                  tvSeriesSeason: tvSeriesDetail.numberOfSeasons,
                ));
            return SafeArea(
              child: TvSeriesDetailContent(tvSeriesDetail: tvSeriesDetail),
            );
          } else if (state is TvSeriesDetailError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox(width: MediaQuery.of(context).size.width);
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatelessWidget {
  const TvSeriesDetailContent({required this.tvSeriesDetail, super.key});

  final TvSeriesDetail tvSeriesDetail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: MediaQuery.of(context).size.width,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tvSeriesDetail.name, style: kHeading5),
                            BlocListener<TvSeriesWatchlistBloc,
                                TvSeriesWatchlistState>(
                              listener: (context, state) {
                                if (state is TvSeriesWatchlistLoaded) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is TvSeriesWatchlistError) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(state.message),
                                        );
                                      });
                                }
                              },
                              child: BlocBuilder<TvSeriesWatchlistStatusBloc,
                                  TvSeriesWatchlistStatusState>(
                                builder: (context, state) {
                                  if (state is TvSeriesWatchlistStatusLoaded) {
                                    final isTvSeriesExistAtWatchlist =
                                        state.isExistAtWatchlist;
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (!isTvSeriesExistAtWatchlist) {
                                          context
                                              .read<TvSeriesWatchlistBloc>()
                                              .add(SaveTvSeriesToWatchlist(
                                                tvSeriesDetail: tvSeriesDetail,
                                              ));
                                          context
                                              .read<
                                                  TvSeriesWatchlistStatusBloc>()
                                              .add(CheckTvSeriesOnWatchlist(
                                                tvSeriesId: tvSeriesDetail.id,
                                              ));
                                        } else {
                                          context
                                              .read<TvSeriesWatchlistBloc>()
                                              .add(RemoveTvSeriesToWatchlist(
                                                tvSeriesDetail: tvSeriesDetail,
                                              ));
                                          context
                                              .read<
                                                  TvSeriesWatchlistStatusBloc>()
                                              .add(CheckTvSeriesOnWatchlist(
                                                tvSeriesId: tvSeriesDetail.id,
                                              ));
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          isTvSeriesExistAtWatchlist
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add),
                                          const Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                            Text(_showGenres(tvSeriesDetail.genres)),
                            Text(
                              "Season : ${tvSeriesDetail.lastEpisodeToAir.seasonNumber}",
                            ),
                            Text(
                              "Episode : ${tvSeriesDetail.lastEpisodeToAir.episodeNumber}",
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tvSeriesDetail.overview),
                            const SizedBox(height: 16),
                            Text('Episode', style: kHeading6),
                            BlocBuilder<TvSeriesEpisodeBloc,
                                TvSeriesEpisodeState>(
                              builder: (context, state) {
                                if (state is TvSeriesEpisodeLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is TvSeriesEpisodeLoaded) {
                                  final episodes = state.episodes;
                                  return SizedBox(
                                    height: 150,
                                    child: episodes.isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final episode = episodes[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  width: 150,
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.amber,
                                                  ),
                                                  child: Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Text(
                                                        '${episode.name} - Episode ${episode.episodeNumber}',
                                                        style: kBodyText,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: episodes.length,
                                          )
                                        : Center(
                                            child: Text(
                                                'Episode Tidak Ditemukan',
                                                style: kBodyText),
                                          ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text('Seasons', style: kHeading6),
                            SizedBox(
                              height: 150,
                              child: tvSeriesDetail.seasons.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season =
                                            tvSeriesDetail.seasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: season.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: tvSeriesDetail.seasons.length,
                                    )
                                  : Center(
                                      child: Text(
                                        'Season Tidak Ditemukan',
                                        style: kBodyText,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            BlocBuilder<TvSeriesRecommendationBloc,
                                TvSeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationLoaded) {
                                  final tvSeriesList = state.tvSeries;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = tvSeriesList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: tvSeriesList.length,
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

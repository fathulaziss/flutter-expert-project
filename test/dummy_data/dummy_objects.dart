import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvSeriesTable = TvSeriesTable(
  id: 2224,
  name: 'The Daily Show',
  posterPath: '/ixcfyK7it6FjRM36Te4OdblAq4X.jpg',
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
);

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
  firstAirDate: "1996-07-22",
  genres: <Genre>[
    Genre(id: 10763, name: "News"),
    Genre(id: 35, name: "Comedy"),
  ],
  id: 2224,
  name: "The Daily Show",
  originalName: "The Daily Show",
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  voteAverage: 6.323,
  voteCount: 468,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 2224,
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  name: 'The Daily Show',
);

final testTvSeriesMap = {
  'id': 2224,
  'overview':
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  'posterPath': "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  'name': 'The Daily Show',
};

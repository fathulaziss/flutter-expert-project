import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
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

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: "/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg",
  genreIds: const [35, 10767],
  id: 59941,
  originCountry: const ["US"],
  originalLanguage: "en",
  originalName: "The Tonight Show Starring Jimmy Fallon",
  overview:
      "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
  popularity: 6096.757,
  posterPath: "/xFOVcKxo7SSexJiLsTw2PrbNGcZ.jpg",
  firstAirDate: "2014-02-17",
  name: "The Tonight Show Starring Jimmy Fallon",
  voteAverage: 5.809,
  voteCount: 277,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
  episodeRunTime: [30, 22],
  firstAirDate: "1996-07-22",
  genres: <Genre>[
    Genre(id: 10763, name: "News"),
    Genre(id: 35, name: "Comedy"),
  ],
  homepage: "https://www.cc.com/shows/the-daily-show",
  id: 2224,
  inProduction: true,
  languages: ["en"],
  lastAirDate: "2024-02-15",
  lastEpisodeToAir: LastEpisodeToAir(
    id: 5101843,
    name: "February 15, 2024 - Cord Jefferson",
    overview:
        "Jordan Klepper covers a sex scandal in the Fulton County, GA, D.A.'s office, Grace Kuhlenschmidt swoons over adulterous presidents, and director Cord Jefferson discusses \"American Fiction.\"",
    voteAverage: 0,
    voteCount: 0,
    airDate: "2024-02-15",
    episodeNumber: 4,
    episodeType: "standard",
    productionCode: "",
    runtime: 24,
    seasonNumber: 29,
    showId: 2224,
    stillPath: "/xhZlEPRlG71Wo8gvz6fCzWmY7kE.jpg",
  ),
  name: "The Daily Show",
  numberOfEpisodes: 3887,
  numberOfSeasons: 29,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The Daily Show",
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  popularity: 3092.914,
  posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  seasons: [
    Season(
      airDate: "1999-12-15",
      episodeCount: 89,
      id: 6869,
      name: "Specials",
      overview: "",
      posterPath: "",
      seasonNumber: 0,
      voteAverage: 0,
    )
  ],
  voteAverage: 6.3,
  voteCount: 471,
);

const testTvSeriesEpisodes = [
  Episode(
    airDate: "2024-02-12",
    episodeNumber: 1,
    id: 5098193,
    name: "February 12, 2024 - Zanny Minton Beddoes",
    overview:
        "Jon Stewart looks at President Biden and Donald Trump's advanced ages, the news team visits a true American diner, and The Economist's Zanny Minton Beddoes examines national conservatism.",
    productionCode: "",
    runtime: 43,
    seasonNumber: 29,
    showId: 2224,
    stillPath: "/coaGUC0F5Flm7DJAokqWpI1Y2aL.jpg",
    voteAverage: 0,
    voteCount: 0,
  ),
];

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 2224,
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  name: 'The Daily Show',
);

const testTvSeriesTable = TvSeriesTable(
  id: 2224,
  name: 'The Daily Show',
  posterPath: '/ixcfyK7it6FjRM36Te4OdblAq4X.jpg',
  overview:
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
);

final testTvSeriesMap = {
  'id': 2224,
  'overview':
      "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
  'posterPath': "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
  'name': 'The Daily Show',
};

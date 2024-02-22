import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesDetailResponse = TvSeriesDetailResponse(
    adult: false,
    backdropPath: "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
    episodeRunTime: [30, 22],
    firstAirDate: "1996-07-22",
    genres: [
      GenreModel(id: 10763, name: "News"),
      GenreModel(id: 35, name: "Comedy"),
    ],
    homepage: "https://www.cc.com/shows/the-daily-show",
    id: 2224,
    inProduction: true,
    languages: ["en"],
    lastAirDate: "2024-02-15",
    lastEpisodeToAir: LastEpisodeToAirModel(
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
      SeasonModel(
        airDate: "1999-12-15",
        episodeCount: 89,
        id: 6869,
        name: "Specials",
        overview: "",
        posterPath: "posterPath",
        seasonNumber: 0,
        voteAverage: 0,
      )
    ],
    voteAverage: 6.3,
    voteCount: 471,
  );

  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
    episodeRunTime: [30, 22],
    firstAirDate: "1996-07-22",
    genres: [
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
        posterPath: "posterPath",
        seasonNumber: 0,
        voteAverage: 0,
      )
    ],
    voteAverage: 6.3,
    voteCount: 471,
  );

  group('Tv Series Detail Response', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_detail.json'));
      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesDetailResponse);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/y4w232QOzDD1McRocp2htMVmF3b.jpg",
        "episode_run_time": [30, 22],
        "first_air_date": "1996-07-22",
        "genres": [
          {"id": 10763, "name": "News"},
          {"id": 35, "name": "Comedy"}
        ],
        "homepage": "https://www.cc.com/shows/the-daily-show",
        "id": 2224,
        "in_production": true,
        "languages": ["en"],
        "last_air_date": "2024-02-15",
        "last_episode_to_air": {
          "id": 5101843,
          "name": "February 15, 2024 - Cord Jefferson",
          "overview":
              "Jordan Klepper covers a sex scandal in the Fulton County, GA, D.A.'s office, Grace Kuhlenschmidt swoons over adulterous presidents, and director Cord Jefferson discusses \"American Fiction.\"",
          "vote_average": 0,
          "vote_count": 0,
          "air_date": "2024-02-15",
          "episode_number": 4,
          "episode_type": "standard",
          "production_code": "",
          "runtime": 24,
          "season_number": 29,
          "show_id": 2224,
          "still_path": "/xhZlEPRlG71Wo8gvz6fCzWmY7kE.jpg"
        },
        "name": "The Daily Show",
        "number_of_episodes": 3887,
        "number_of_seasons": 29,
        "origin_country": ["US"],
        "original_language": "en",
        "original_name": "The Daily Show",
        "overview":
            "The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
        "popularity": 3092.914,
        "poster_path": "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
        "seasons": [
          {
            "air_date": "1999-12-15",
            "episode_count": 89,
            "id": 6869,
            "name": "Specials",
            "overview": "",
            "poster_path": "posterPath",
            "season_number": 0,
            "vote_average": 0
          }
        ],
        "vote_average": 6.3,
        "vote_count": 471
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of Tv Series Detail Response entity', () async {
    final result = tTvSeriesDetailResponse.toEntity();
    expect(result, tTvSeriesDetail);
  });
}

import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_response_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tSeasonDetailResponseModel = SeasonDetailResponseModel(
    airDate: "2024-02-12",
    episodes: [
      EpisodeModel(
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
      )
    ],
    name: "Season 29",
    overview: "",
    id: 375682,
    ids: "65b17e45b76cbb01732bb7ed",
    posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
    seasonNumber: 29,
    voteAverage: 0,
  );

  const tSeasonDetailResponse = SeasonDetailResponse(
    airDate: "2024-02-12",
    episodes: [
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
      )
    ],
    name: "Season 29",
    overview: "",
    id: 375682,
    ids: "65b17e45b76cbb01732bb7ed",
    posterPath: "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
    seasonNumber: 29,
    voteAverage: 0,
  );

  group('Season Detail Response Model', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_season_detail.json'));
      // act
      final result = SeasonDetailResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tSeasonDetailResponseModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonDetailResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "65b17e45b76cbb01732bb7ed",
        "air_date": "2024-02-12",
        "episodes": [
          {
            "air_date": "2024-02-12",
            "episode_number": 1,
            "id": 5098193,
            "name": "February 12, 2024 - Zanny Minton Beddoes",
            "overview":
                "Jon Stewart looks at President Biden and Donald Trump's advanced ages, the news team visits a true American diner, and The Economist's Zanny Minton Beddoes examines national conservatism.",
            "production_code": "",
            "runtime": 43,
            "season_number": 29,
            "show_id": 2224,
            "still_path": "/coaGUC0F5Flm7DJAokqWpI1Y2aL.jpg",
            "vote_average": 0,
            "vote_count": 0
          }
        ],
        "name": "Season 29",
        "overview": "",
        "id": 375682,
        "poster_path": "/ixcfyK7it6FjRM36Te4OdblAq4X.jpg",
        "season_number": 29,
        "vote_average": 0
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of Season Detail Response entity', () async {
    final result = tSeasonDetailResponseModel.toEntity();
    expect(result, tSeasonDetailResponse);
  });
}

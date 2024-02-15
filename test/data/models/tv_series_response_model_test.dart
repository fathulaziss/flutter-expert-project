import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg",
    genreIds: [35, 10767],
    id: 59941,
    originCountry: ["US"],
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

  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg",
            "genre_ids": [35, 10767],
            "id": 59941,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "The Tonight Show Starring Jimmy Fallon",
            "overview":
                "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
            "popularity": 6096.757,
            "poster_path": "/xFOVcKxo7SSexJiLsTw2PrbNGcZ.jpg",
            "first_air_date": "2014-02-17",
            "name": "The Tonight Show Starring Jimmy Fallon",
            "vote_average": 5.809,
            "vote_count": 277
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

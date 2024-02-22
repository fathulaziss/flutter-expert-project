import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_response.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    imdbId: "imdb1",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    revenue: 12000,
    runtime: 120,
    status: "Status",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: "/path.jpg",
    genres: [Genre(id: 1, name: "Action")],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    runtime: 120,
    title: "Title",
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Movie Detail Response', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie_detail.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieDetailResponse);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "budget": 100,
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "homepage": "https://google.com",
        "id": 1,
        "imdb_id": "imdb1",
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "release_date": "2020-05-05",
        "revenue": 12000,
        "runtime": 120,
        "status": "Status",
        "tagline": "Tagline",
        "title": "Title",
        "video": false,
        "vote_average": 1.0,
        "vote_count": 1
      };
      expect(result, expectedJsonMap);
    });

    test('should be a subclass of Movie Detail entity', () async {
      final result = tMovieDetailResponse.toEntity();
      expect(result, tMovieDetail);
    });
  });
}

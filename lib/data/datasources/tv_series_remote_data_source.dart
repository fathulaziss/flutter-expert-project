// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_response_model.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
  Future<List<EpisodeModel>> getTvSeriesEpisodes(int id, int season);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  final IOClient? ioClient;

  TvSeriesRemoteDataSourceImpl({required this.client, this.ioClient});

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    if (ioClient != null) {
      final response =
          await ioClient!.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    } else {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    if (ioClient != null) {
      final response =
          await ioClient!.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } else {
      final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    if (ioClient != null) {
      final response = await ioClient!
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    } else {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    if (ioClient != null) {
      final response =
          await ioClient!.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    } else {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    if (ioClient != null) {
      final response =
          await ioClient!.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    } else {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<EpisodeModel>> getTvSeriesEpisodes(int id, int season) async {
    if (ioClient != null) {
      final response = await ioClient!
          .get(Uri.parse('$BASE_URL/tv/$id/season/$season?$API_KEY'));

      if (response.statusCode == 200) {
        return SeasonDetailResponseModel.fromJson(json.decode(response.body))
            .episodes;
      } else {
        throw ServerException();
      }
    } else {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/$id/season/$season?$API_KEY'));

      if (response.statusCode == 200) {
        return SeasonDetailResponseModel.fromJson(json.decode(response.body))
            .episodes;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    if (ioClient != null) {
      final response = await ioClient!
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    } else {
      final response = await client
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        return TvSeriesResponse.fromJson(json.decode(response.body))
            .tvSeriesList;
      } else {
        throw ServerException();
      }
    }
  }
}

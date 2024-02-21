import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/season_detail_response.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponseModel extends Equatable {
  const SeasonDetailResponseModel({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.ids,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int id;
  final String ids;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  factory SeasonDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponseModel(
        airDate: json["air_date"] ?? '',
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"] ?? '',
        overview: json["overview"] ?? '',
        id: json["id"] ?? 0,
        ids: json["_id"] ?? '',
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "_id": ids,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  SeasonDetailResponse toEntity() {
    return SeasonDetailResponse(
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      id: id,
      ids: ids,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        name,
        overview,
        id,
        ids,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}

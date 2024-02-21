import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  const SeasonDetailResponse({
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
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int id;
  final String ids;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;

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

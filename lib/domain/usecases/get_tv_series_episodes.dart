import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesEpisodes {
  final TvSeriesRepository repository;

  GetTvSeriesEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int season) {
    return repository.getTvSeriesEpisodes(id, season);
  }
}

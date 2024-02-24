import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail})
      : super(const MovieDetailInitial(state: RequestState.Empty)) {
    on<FetchMovieDetail>((event, emit) async {
      emit(const MovieDetailLoading(state: RequestState.Loading));

      final result = await getMovieDetail.execute(event.movieId);

      result.fold(
        (failure) {
          emit(MovieDetailError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (movieDetailData) {
          emit(MovieDetailLoaded(
            movieDetail: movieDetailData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

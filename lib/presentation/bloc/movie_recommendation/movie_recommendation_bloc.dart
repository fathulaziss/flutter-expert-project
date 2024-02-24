import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(const MovieRecommendationInitial(state: RequestState.Empty)) {
    on<FetchMovieRecommendation>((event, emit) async {
      emit(const MovieRecommendationLoading(state: RequestState.Loading));

      final result = await getMovieRecommendations.execute(event.movieId);

      result.fold(
        (failure) {
          emit(MovieRecommendationError(
            message: failure.message,
            state: RequestState.Error,
          ));
        },
        (moviesData) {
          emit(MovieRecommendationLoaded(
            movies: moviesData,
            state: RequestState.Loaded,
          ));
        },
      );
    });
  }
}

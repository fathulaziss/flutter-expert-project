part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {
  final RequestState state;

  const MovieDetailInitial({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieDetailLoading extends MovieDetailState {
  final RequestState state;

  const MovieDetailLoading({required this.state});

  @override
  List<Object> get props => [state];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final RequestState state;

  const MovieDetailLoaded({
    required this.movieDetail,
    required this.state,
  });

  @override
  List<Object> get props => [movieDetail, state];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  final RequestState state;

  const MovieDetailError({required this.message, required this.state});

  @override
  List<Object> get props => [message, state];
}

// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/movie_search_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as i5;

import 'package:dartz/dartz.dart' as i3;
import 'package:ditonton/common/failure.dart' as i6;
import 'package:ditonton/domain/entities/movie.dart' as i7;
import 'package:ditonton/domain/repositories/movie_repository.dart' as i2;
import 'package:ditonton/domain/usecases/search_movies.dart' as i4;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeMovieRepository extends i1.Fake implements i2.MovieRepository {}

class _FakeEither<L, R> extends i1.Fake implements i3.Either<L, R> {}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends i1.Mock implements i4.SearchMovies {
  MockSearchMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
              returnValue: Future<i3.Either<i6.Failure, List<i7.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i7.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i7.Movie>>>);
}

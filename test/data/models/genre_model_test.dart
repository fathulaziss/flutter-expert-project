import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  group('Genre Model', () {
    test('should be a subclass of Genre entity', () async {
      final result = tGenreModel.toEntity();
      expect(result, tGenre);
    });
  });
}

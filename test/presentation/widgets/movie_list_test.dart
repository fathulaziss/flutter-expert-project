import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('Widget MovieList should display ListView when data is exist',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MovieList(testMovieList))));

    final listViewFinder = find.byType(ListView);

    expect(listViewFinder, findsOneWidget);
  });
}

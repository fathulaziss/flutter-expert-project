import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('Widget MovieCard should display Container when data is exist',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: MovieCard(testMovie))));

    final listViewFinder = find.text(testMovie.title ?? '-');

    expect(listViewFinder, findsOneWidget);
  });
}

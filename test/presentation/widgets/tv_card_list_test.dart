import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('Widget TvSeriesCard should display Container when data is exist',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TvSeriesCard(testTvSeries))));

    final listViewFinder = find.text(testTvSeries.name ?? '-');

    expect(listViewFinder, findsOneWidget);
  });
}

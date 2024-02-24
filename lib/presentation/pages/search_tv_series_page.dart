// ignore_for_file: constant_identifier_names

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series';

  const SearchTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvSeriesSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
              builder: (context, state) {
                if (state is TvSeriesSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TvSeriesSearchLoaded) {
                  final tvSeriesList = state.tvSeries;
                  return Expanded(
                    child: tvSeriesList.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tvSeries = tvSeriesList[index];
                              return TvSeriesCard(tvSeries);
                            },
                            itemCount: tvSeriesList.length,
                          )
                        : Center(
                            child: Text(
                              'Tv Series Tidak Ditemukan',
                              textAlign: TextAlign.center,
                              style: kBodyText,
                            ),
                          ),
                  );
                } else if (state is TvSeriesSearchError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

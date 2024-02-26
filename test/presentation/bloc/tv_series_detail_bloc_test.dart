import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc =
        TvSeriesDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  group('Tv Series Detail BLoC', () {
    test('Initial state should be empty', () {
      expect(
        tvSeriesDetailBloc.state,
        const TvSeriesDetailInitial(state: RequestState.Empty),
      );
    });

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(1))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) {
        bloc.add(const FetchTvSeriesDetail(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesDetailLoading(state: RequestState.Loading),
          const TvSeriesDetailLoaded(
            tvSeriesDetail: testTvSeriesDetail,
            state: RequestState.Loaded,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(1));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) {
        bloc.add(const FetchTvSeriesDetail(tvSeriesId: 1));
      },
      expect: () {
        return [
          const TvSeriesDetailLoading(state: RequestState.Loading),
          const TvSeriesDetailError(
            message: 'Server Failure',
            state: RequestState.Error,
          ),
        ];
      },
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(1));
      },
    );
  });
}

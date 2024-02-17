import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 59941;

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/xl1wGwaPZInJo1JAnpKqnFozWBE.jpg",
    genreIds: const [35, 10767],
    id: 59941,
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "The Tonight Show Starring Jimmy Fallon",
    overview:
        "After Jay Leno's second retirement from the program, Jimmy Fallon stepped in as his permanent replacement. After 42 years in Los Angeles the program was brought back to New York.",
    popularity: 6096.757,
    posterPath: "/xFOVcKxo7SSexJiLsTw2PrbNGcZ.jpg",
    firstAirDate: "2014-02-17",
    name: "The Tonight Show Starring Jimmy Fallon",
    voteAverage: 5.809,
    voteCount: 277,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  void arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.Loaded);
      expect(provider.tvSeriesDetail, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationTvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationTvSeriesState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist Tv Series', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvSeriesStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistTvSeriesStatus(1);
      // assert
      expect(provider.isAddedToWatchlistTvSeries, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id));
      expect(provider.isAddedToWatchlistTvSeries, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

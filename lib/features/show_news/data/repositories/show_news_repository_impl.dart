import 'package:dartz/dartz.dart';
import 'package:news_app_clean/core/error/exeptions.dart';
import 'package:news_app_clean/core/error/failures.dart';
import 'package:news_app_clean/core/network/network_info.dart';
import '../datasources/show_news_remote_data_source.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/show_news_repository.dart';

typedef _CategoryChooser = Future<List<Article>> Function();

class ShowNewsRepositoryImpl implements ShowNewsRepository {
  final ShowNewsRemoteDataSource showNewsRemoteDataSource;
  final NetworkInfo networkInfo;

  ShowNewsRepositoryImpl(
      {required this.showNewsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Article>>> getBusinessArticles() async {
    return await _getCategoryArticles(
        () => showNewsRemoteDataSource.getBusinessArticles());
  }

  @override
  Future<Either<Failure, List<Article>>> getScienceArticles() async {
    return await _getCategoryArticles(
        () => showNewsRemoteDataSource.getScienceArticles());
  }

  @override
  Future<Either<Failure, List<Article>>> getSportsArticles() async {
    return await _getCategoryArticles(
        () => showNewsRemoteDataSource.getSportsArticles());
  }

  Future<Either<Failure, List<Article>>> _getCategoryArticles(
      _CategoryChooser categoryChooser) async {
    if (!await networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }
    try {
      final remoteArticles = await categoryChooser();
      return Right(remoteArticles);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

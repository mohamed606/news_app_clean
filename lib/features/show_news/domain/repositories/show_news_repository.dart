import 'package:dartz/dartz.dart';
import 'package:news_app_clean/core/error/failures.dart';
import 'package:news_app_clean/features/show_news/domain/entities/article.dart';

abstract class ShowNewsRepository{
  Future<Either<Failure, List<Article>>> getBusinessArticles();
  Future<Either<Failure, List<Article>>> getSportsArticles();
  Future<Either<Failure, List<Article>>> getScienceArticles();
}
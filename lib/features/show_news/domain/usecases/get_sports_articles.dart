import 'package:dartz/dartz.dart';
import 'package:news_app_clean/core/error/failures.dart';
import 'package:news_app_clean/core/usecases/usecase.dart';
import 'package:news_app_clean/features/show_news/domain/entities/article.dart';
import 'package:news_app_clean/features/show_news/domain/repositories/show_news_repository.dart';

class GetSportsArticles extends UseCase<List<Article>, NoParams>{
  final ShowNewsRepository showNewsRepository;

  GetSportsArticles({required this.showNewsRepository});

  @override
  Future<Either<Failure, List<Article>>> call(NoParams param) async{
    return showNewsRepository.getSportsArticles();
  }
}
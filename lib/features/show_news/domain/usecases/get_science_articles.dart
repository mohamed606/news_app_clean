import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/show_news_repository.dart';

class GetScienceArticles extends UseCase<List<Article>, NoParams>{
  final ShowNewsRepository showNewsRepository;

  GetScienceArticles({required this.showNewsRepository});

  @override
  Future<Either<Failure, List<Article>>> call(NoParams param) async{
    return showNewsRepository.getScienceArticles();
  }
}
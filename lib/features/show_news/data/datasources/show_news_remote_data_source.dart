import 'dart:convert';
import 'package:news_app_clean/core/error/exeptions.dart';
import 'package:news_app_clean/core/util/constants.dart';
import 'package:news_app_clean/features/show_news/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class ShowNewsRemoteDataSource {
  Future<List<ArticleModel>> getBusinessArticles();

  Future<List<ArticleModel>> getSportsArticles();

  Future<List<ArticleModel>> getScienceArticles();
}

const String BASE_URL = 'newsapi.org';
const String TOP_HEADLINE_ENDPOINT = '/v2/top-headlines';

class ShowNewsRemoteDataSourceImpl implements ShowNewsRemoteDataSource {
  final http.Client client;

  ShowNewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getBusinessArticles() {
    return _getArticles('business');
  }

  @override
  Future<List<ArticleModel>> getScienceArticles() {
    return _getArticles('science');
  }

  @override
  Future<List<ArticleModel>> getSportsArticles() {
    return _getArticles('sports');
  }

  Future<List<ArticleModel>> _getArticles(String category) async {
    final queryParameters = {
      'country': 'eg',
      'category': category,
      'apiKey': apiKey,
    };
    final uri = Uri.https(BASE_URL, TOP_HEADLINE_ENDPOINT, queryParameters);
    print(uri);
    final response = await client.get(uri);
    if (response.statusCode != 200) throw ServerException();
    final jsonResponse = json.decode(response.body);
    List<ArticleModel> articles = [];
    for (var article in jsonResponse['articles']){
      articles.add(ArticleModel.fromJson(article));
    }
    return articles;
  }
}

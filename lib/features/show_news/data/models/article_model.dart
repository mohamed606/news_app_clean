import 'package:news_app_clean/features/show_news/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel(
      {required String title,
      required String image,
      required String publishedAt})
      : super(title: title, image: image, publishedAt: publishedAt);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        title: json['title'],
        image: json['urlToImage'] ??
            "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
        publishedAt: json['publishedAt']);
  }
}

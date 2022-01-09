import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String image;
  final String publishedAt;

  Article(
      {required this.title, required this.image, required this.publishedAt});

  @override
  // TODO: implement props
  List<Object?> get props => [title, image, publishedAt];
}

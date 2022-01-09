part of 'show_news_bloc.dart';

abstract class ShowNewsEvent extends Equatable {
  const ShowNewsEvent();
}

class GetBusinessArticlesEvent extends ShowNewsEvent{
  @override
  List<Object?> get props => [];
}
class GetSportsArticlesEvent extends ShowNewsEvent{
  @override
  List<Object?> get props => [];
}
class GetScienceArticlesEvent extends ShowNewsEvent{
  @override
  List<Object?> get props => [];
}
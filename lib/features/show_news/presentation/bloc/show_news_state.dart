part of 'show_news_bloc.dart';

abstract class ShowNewsState extends Equatable {
  const ShowNewsState();
}

class ShowNewsInitial extends ShowNewsState {
  @override
  List<Object> get props => [];
}

class ShowNewsLoading extends ShowNewsState{
  @override
  List<Object?> get props => [];
}

class ShowNewsLoaded extends ShowNewsState{
  final List<Article> articles;

  ShowNewsLoaded({required this.articles});

  @override
  List<Object?> get props => [articles];
}

class ShowNewsError extends ShowNewsState{
  final String errorMessage;

  ShowNewsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
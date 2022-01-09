import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean/core/error/failures.dart';
import 'package:news_app_clean/core/usecases/usecase.dart';
import 'package:news_app_clean/features/show_news/domain/entities/article.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_business_articles.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_science_articles.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_sports_articles.dart';

part 'show_news_event.dart';

part 'show_news_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NO_CONNECTION_FAILURE_MESSAGE = 'No internet connection';

class ShowNewsBloc extends Bloc<ShowNewsEvent, ShowNewsState> {
  final GetBusinessArticles getBusinessArticles;
  final GetScienceArticles getScienceArticles;
  final GetSportsArticles getSportsArticles;

  ShowNewsBloc(
      {required this.getBusinessArticles,
      required this.getScienceArticles,
      required this.getSportsArticles})
      : super(ShowNewsInitial()) {
    on<ShowNewsEvent>((event, emit) async {
      emit(ShowNewsLoading());
      if (event is GetBusinessArticlesEvent) {
        final failureOrArticles = await getBusinessArticles(NoParams());
        _eitherLoadedOrErrorState(failureOrArticles, emit);
      } else if (event is GetScienceArticlesEvent) {
        final failureOrArticles = await getScienceArticles(NoParams());
        _eitherLoadedOrErrorState(failureOrArticles, emit);
      } else if (event is GetSportsArticlesEvent) {
        final failureOrArticles = await getSportsArticles(NoParams());
        _eitherLoadedOrErrorState(failureOrArticles, emit);
      }
    });
  }

  void _eitherLoadedOrErrorState(
      Either<Failure, List<Article>> failureOrArticles,
      Emitter<ShowNewsState> emit) {
    failureOrArticles.fold(
        (failure) =>
            emit(ShowNewsError(errorMessage: _mapFailureToMessage(failure))),
        (articles) => emit(ShowNewsLoaded(articles: articles)));
  }
}

String _mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure)
    return SERVER_FAILURE_MESSAGE;
  else if (failure is NoConnectionFailure)
    return NO_CONNECTION_FAILURE_MESSAGE;
  else
    return "Unexpected error";
}

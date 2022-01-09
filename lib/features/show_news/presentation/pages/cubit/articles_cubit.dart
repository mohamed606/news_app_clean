import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  static ArticlesCubit get(context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  List<String> categories = ["business", "sports", "science"];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.work,
      ),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
  ];

  void changeBottomNaveIndex(int index){
    emit(ChangeBottomNavIndex());
    bottomNavCurrentIndex = index;
    emit(ChangedBottomNavIndex());
  }

}

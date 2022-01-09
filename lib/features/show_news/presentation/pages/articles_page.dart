import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean/features/show_news/presentation/bloc/show_news_bloc.dart';
import 'package:news_app_clean/features/show_news/presentation/pages/cubit/articles_cubit.dart';
import 'package:news_app_clean/features/show_news/presentation/widgets/articles_display.dart';
import 'package:news_app_clean/features/show_news/presentation/widgets/error_message_display.dart';
import 'package:news_app_clean/features/show_news/presentation/widgets/loading_widget.dart';

import '../../../../injection_container.dart';

class ArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticlesCubit(),
        ),
        BlocProvider(
          create: (_) => sl<ShowNewsBloc>(),
        ),
      ],
      child: BlocConsumer<ArticlesCubit, ArticlesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ArticlesCubit.get(context);
          final String defaultCategory =
              cubit.categories[cubit.bottomNavCurrentIndex];
          return Scaffold(
            appBar: AppBar(
              title: const Text('News'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.bottomNavCurrentIndex,
              onTap: (index) {
                cubit.changeBottomNaveIndex(index);
                dispatchEvent(
                    category: cubit.categories[index], context: context);
              },
            ),
            body: buildBody(defaultCategory),
          );
        },
      ),
    );
  }

  BlocBuilder<ShowNewsBloc, ShowNewsState> buildBody(String defaultCategory) {
    return BlocBuilder<ShowNewsBloc, ShowNewsState>(
            builder: (context, state) {
              if (state is ShowNewsInitial)
                dispatchEvent(category: defaultCategory, context: context);
              if (state is ShowNewsLoaded)
                return ArticlesDisplay(articles: state.articles);
              else if (state is ShowNewsError)
                return ErrorMessageDisplay(message: state.errorMessage);
              else
                return LoadingWidget();
            },
          );
  }

  void dispatchEvent(
      {required String category, required BuildContext context}) {
    BlocProvider.of<ShowNewsBloc>(context).add(_mapCategoryToEvent(category));
  }

  ShowNewsEvent _mapCategoryToEvent(String category) {
    if (category == 'sports')
      return GetSportsArticlesEvent();
    else if (category == 'science')
      return GetScienceArticlesEvent();
    else
      return GetBusinessArticlesEvent();
  }
}

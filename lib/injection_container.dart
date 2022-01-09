import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_clean/core/network/network_info.dart';
import 'package:news_app_clean/features/show_news/data/datasources/show_news_remote_data_source.dart';
import 'package:news_app_clean/features/show_news/data/repositories/show_news_repository_impl.dart';
import 'package:news_app_clean/features/show_news/domain/repositories/show_news_repository.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_business_articles.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_science_articles.dart';
import 'package:news_app_clean/features/show_news/domain/usecases/get_sports_articles.dart';
import 'package:news_app_clean/features/show_news/presentation/bloc/show_news_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  await initExternal();
  initCore();
  initFeatures();
}

void initFeatures() {
  sl.registerSingleton<ShowNewsRemoteDataSource>(ShowNewsRemoteDataSourceImpl(client: sl()));
  sl.registerSingleton<ShowNewsRepository>(ShowNewsRepositoryImpl(
    networkInfo: sl(),
    showNewsRemoteDataSource: sl(),
  ));
  sl.registerSingleton(GetBusinessArticles(showNewsRepository: sl()));
  sl.registerSingleton(GetScienceArticles(showNewsRepository: sl()));
  sl.registerSingleton(GetSportsArticles(showNewsRepository: sl()));
  sl.registerFactory(() => ShowNewsBloc(
      getBusinessArticles: sl(),
      getScienceArticles: sl(),
      getSportsArticles: sl()));
}

void initCore(){
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()));
}

Future<void> initExternal() async{
  sl.registerSingleton(http.Client());
  sl.registerSingleton(InternetConnectionChecker());
}

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// NEWS
import 'features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'features/daily_news/data/repository/article_repository_impl.dart';
import 'features/daily_news/domain/repository/article_repository.dart';
import 'features/daily_news/domain/usecases/get_article.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

// USER ARTICLES
import 'features/user_articles/data/data_sources/user_article_remote_data_source.dart';
import 'features/user_articles/data/repositories/user_article_repository_impl.dart';
import 'features/user_articles/domain/repository/user_article_repository.dart';
import 'features/user_articles/domain/usecases/get_user_articles_usecase.dart';
import 'features/user_articles/presentation/bloc/user_articles_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  // NEWS
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(), sl(), sl()));

  // USER ARTICLES
  sl.registerLazySingleton<UserArticleRemoteDataSource>(
      () => UserArticleRemoteDataSourceImpl(FirebaseFirestore.instance));

  sl.registerSingleton<UserArticleRepository>(
      UserArticleRepositoryImpl(sl()));

  sl.registerSingleton<GetUserArticlesUseCase>(
      GetUserArticlesUseCase(sl()));

  sl.registerFactory<UserArticlesBloc>(() => UserArticlesBloc(sl()));
}

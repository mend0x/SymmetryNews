import '../../domain/entities/user_article_entity.dart';

abstract class UserArticlesState {}

class UserArticlesInitialState extends UserArticlesState {}

class UserArticlesLoadingState extends UserArticlesState {}

class UserArticlesLoadedState extends UserArticlesState {
  final List<UserArticleEntity> articles;
  UserArticlesLoadedState(this.articles);
}

class UserArticlesErrorState extends UserArticlesState {
  final String message;
  UserArticlesErrorState(this.message);
}

class UserArticleCreatingState extends UserArticlesState {}

class UserArticleCreatedState extends UserArticlesState {}

class UserArticleCreateErrorState extends UserArticlesState {
  final String message;
  UserArticleCreateErrorState(this.message);
}

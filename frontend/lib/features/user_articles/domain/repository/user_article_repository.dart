import '../entities/user_article_entity.dart';

abstract class UserArticleRepository {
  Future<List<UserArticleEntity>> getUserArticles();
}

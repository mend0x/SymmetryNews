import '../entities/user_article_entity.dart';
import '../repository/user_article_repository.dart';

class GetUserArticlesUseCase {
  final UserArticleRepository repository;

  GetUserArticlesUseCase(this.repository);

  Future<List<UserArticleEntity>> call() async {
    return await repository.getUserArticles();
  }
}

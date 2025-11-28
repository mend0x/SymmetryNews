import '../../domain/entities/user_article_entity.dart';
import '../../domain/repository/user_article_repository.dart';
import '../data_sources/user_article_remote_data_source.dart';

class UserArticleRepositoryImpl implements UserArticleRepository {
  final UserArticleRemoteDataSource remoteDataSource;

  UserArticleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserArticleEntity>> getUserArticles() async {
    return await remoteDataSource.getUserArticles();
  }
}

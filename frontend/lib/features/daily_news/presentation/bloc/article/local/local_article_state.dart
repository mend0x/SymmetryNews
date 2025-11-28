import 'package:equatable/equatable.dart';
import '../../../../domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  const LocalArticlesState();

  @override
  List<Object?> get props => [];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  final List<ArticleEntity> articles;

  const LocalArticlesDone(this.articles);

  @override
  List<Object?> get props => [articles];
}

class LocalArticlesError extends LocalArticlesState {
  final String message;

  const LocalArticlesError(this.message);

  @override
  List<Object?> get props => [message];
}

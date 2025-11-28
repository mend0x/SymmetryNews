import 'package:flutter/material.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';

//Nueva ruta:
import '../../features/user_articles/presentation/pages/user_articles_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {

      // HOME
      case '/':
        return _materialRoute(const DailyNews());

      // DETALLE DE NOTICIA
      case '/ArticleDetails':
        return _materialRoute(
          ArticleDetailsView(article: settings.arguments as ArticleEntity),
        );

      // ARTÍCULOS GUARDADOS LOCALMENTE
      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      // ARTÍCULOS (FIREBASE)
      case '/MyArticles':
        return _materialRoute(const UserArticlesPage());

      // DEFAULT
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

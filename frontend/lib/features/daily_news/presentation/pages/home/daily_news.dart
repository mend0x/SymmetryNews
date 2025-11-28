import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

// Tus artículos
import 'package:news_app_clean_architecture/features/user_articles/presentation/pages/user_articles_page.dart';

// Crear artículo
import 'package:news_app_clean_architecture/features/user_articles/presentation/pages/create_article_page.dart';

// 🔥 IMPORT DEL THEMEBLOC
import '../../../../theme/theme_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  AppBar _buildAppbar(BuildContext context) {
    final isDark =
        context.watch<ThemeBloc>().state is ThemeDark; // Saber modo actual

    return AppBar(
      title: Text(
        'Daily News',
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 0,
      actions: [
        // --- Guardados ---
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.bookmark,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),

        // --- Tus Artículos ---
        IconButton(
          icon: Icon(Icons.person, color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserArticlesPage()),
            );
          },
        ),

        // --- 🔥 BOTÓN MODO OSCURO / CLARO ---
        IconButton(
          icon: Icon(
            isDark ? Icons.wb_sunny : Icons.nights_stay,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
        ),
      ],
    );
  }

  Widget _buildPage() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return Scaffold(
            appBar: _buildAppbar(context),
            body: const Center(child: CupertinoActivityIndicator()),
          );
        }

        if (state is RemoteArticlesError) {
          return Scaffold(
            appBar: _buildAppbar(context),
            body: const Center(child: Icon(Icons.refresh)),
          );
        }

        if (state is RemoteArticlesDone) {
          return _buildArticlesPage(context, state.articles!);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildArticlesPage(
      BuildContext context, List<ArticleEntity> articles) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: ListView(
        children: [
          for (var article in articles)
            ArticleWidget(
              article: article,
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            ),
        ],
      ),

      // ---------------------------
      //   BOTÓN ROSA FLOTANTE
      // ---------------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3781FA),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateArticlePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}

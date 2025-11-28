import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_articles_bloc.dart';
import '../bloc/user_articles_state.dart';
import '../bloc/user_articles_event.dart';
import 'package:news_app_clean_architecture/features/user_articles/presentation/pages/article_detail/user_article_details_page.dart';

class UserArticlesPage extends StatelessWidget {
  const UserArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Articles"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Recargar los artículos
          context.read<UserArticlesBloc>().add(GetUserArticlesEvent());
        },
        backgroundColor: const Color(0xFF3781FA),
        child: const Icon(Icons.refresh, size: 30),
      ),

      body: BlocBuilder<UserArticlesBloc, UserArticlesState>(
        builder: (context, state) {
          if (state is UserArticlesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserArticlesErrorState) {
            return Center(
              child: Text("Error: ${state.message}"),
            );
          }

          if (state is UserArticlesLoadedState) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return const Center(
                child: Text("No has creado ningún artículo aún."),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              itemBuilder: (_, i) {
                final a = articles[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserArticleDetailsPage(article: a),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              a.thumbnailURL,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(a.author),
                                Text(
                                  a.date
                                      .toDate()
                                      .toString()
                                      .split(" ")
                                      .first,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

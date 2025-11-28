import 'package:flutter/material.dart';
import '../../domain/entities/user_article_entity.dart';

class UserArticleDetailsPage extends StatelessWidget {
  final UserArticleEntity article;

  const UserArticleDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          article.title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.thumbnailURL,
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// Título
            Text(
              article.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            /// Autor + Fecha
            Row(
              children: [
                Text(
                  "Por ${article.author}",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  article.date.toDate().toString().split(" ").first,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// TAGS (VERSION ORIGINAL)
            if (article.tags.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: article.tags.map((tag) {
                  return Theme(
                    data: ThemeData.light(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3781FA), // COLOR ORIGINAL
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF3781FA),
                        ),
                      ),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(tag),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            /// Contenido
            Text(
              article.content,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

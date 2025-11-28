import 'package:flutter/material.dart';
import '../../../domain/entities/user_article_entity.dart';

class UserArticleDetailsPage extends StatelessWidget {
  final UserArticleEntity article;

  const UserArticleDetailsPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 IMAGEN PRINCIPAL
            if (article.thumbnailURL.isNotEmpty)
              Image.network(
                article.thumbnailURL,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 250, color: Colors.grey),
              ),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🔥 TÍTULO
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔥 AUTOR + FECHA
                  Text(
                    "Por ${article.author} — ${article.date.toDate().toString().split(" ").first}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔥 CONTENIDO
                  Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔥 TAGS
                  if (article.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: article.tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.blue.shade100,
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 40),

                  // FUTURO: BOTÓN DE GUARDAR O COMPARTIR
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: const Text("Guardar"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

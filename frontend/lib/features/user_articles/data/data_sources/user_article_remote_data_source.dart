import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_article_entity.dart';

abstract class UserArticleRemoteDataSource {
  Future<List<UserArticleEntity>> getUserArticles();
}

class UserArticleRemoteDataSourceImpl implements UserArticleRemoteDataSource {
  final FirebaseFirestore firestore;

  // Recibe la instancia desde afuera (NO inicializa Firebase aquí)
  UserArticleRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<UserArticleEntity>> getUserArticles() async {
    final snapshot = await firestore.collection("articles").get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return UserArticleEntity(
        id: doc.id,
        title: data["title"] ?? "",
        content: data["content"] ?? "",
        author: data["author"] ?? "",
        thumbnailURL: data["thumbnailURL"] ?? "",
        tags: List<String>.from(data["tags"] ?? []),
        date: data["date"],
      );
    }).toList();
  }
}

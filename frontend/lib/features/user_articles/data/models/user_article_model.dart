import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_article_entity.dart';

class UserArticleModel extends UserArticleEntity {
  UserArticleModel({
    required super.id,
    required super.title,
    required super.content,
    required super.author,
    required super.date,
    required super.thumbnailURL,
    required super.tags,
  });

  factory UserArticleModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserArticleModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      thumbnailURL: data['thumbnailURL'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
    );
  }
}

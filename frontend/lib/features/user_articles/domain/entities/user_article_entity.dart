import 'package:cloud_firestore/cloud_firestore.dart';

class UserArticleEntity {
  final String id;
  final String title;
  final String content;
  final String author;
  final Timestamp date;
  final String thumbnailURL;
  final List<String> tags;

  UserArticleEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.thumbnailURL,
    required this.tags,
  });
}

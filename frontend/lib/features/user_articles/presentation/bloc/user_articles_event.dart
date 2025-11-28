import 'dart:io';

abstract class UserArticlesEvent {}

class GetUserArticlesEvent extends UserArticlesEvent {}

class CreateUserArticleEvent extends UserArticlesEvent {
  final String title;
  final String content;
  final String author;
  final List<String> tags;
  final File imageFile;

  CreateUserArticleEvent({
    required this.title,
    required this.content,
    required this.author,
    required this.tags,
    required this.imageFile,
  });
}

import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  const Issue({
    required this.id,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.author,
    this.body,
    this.comments,
    this.labels,
    required this.visited,
  });

  final int id;
  final String number;
  final String title;
  final DateTime createdAt;
  final String author;
  final String? body;
  final int? comments;
  final List<String>? labels;
  final bool visited;

  Issue copyWith({
    int? id,
    String? number,
    String? title,
    DateTime? createdAt,
    String? author,
    String? body,
    int? comments,
    List<String>? labels,
    bool? visited,
  }) =>
      Issue(
        id: id ?? this.id,
        number: number ?? this.number,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        author: author ?? this.author,
        body: body ?? this.body,
        comments: comments ?? this.comments,
        labels: labels ?? this.labels,
        visited: visited ?? this.visited,
      );

  @override
  List<Object?> get props => [
        id,
        number,
        title,
        createdAt,
        author,
        body,
        comments,
        labels,
        visited,
      ];
}

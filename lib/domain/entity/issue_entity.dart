import 'package:equatable/equatable.dart';

class IssueEntity extends Equatable {
  const IssueEntity({
    required this.id,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.author,
    this.body,
    this.labels,
    required this.visited,
  });

  final int id;
  final int number;
  final String title;
  final DateTime createdAt;
  final String author;
  final String? body;
  final List<String>? labels;
  final bool visited;

  IssueEntity copyWith({
    int? id,
    int? number,
    String? title,
    DateTime? createdAt,
    String? author,
    String? body,
    List<String>? labels,
    bool? visited,
  }) =>
      IssueEntity(
        id: id ?? this.id,
        number: number ?? this.number,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        author: author ?? this.author,
        body: body ?? this.body,
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
        labels,
        visited,
      ];
}

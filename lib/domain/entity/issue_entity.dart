import 'package:equatable/equatable.dart';

class IssueEntity extends Equatable {
  const IssueEntity({
    required this.id,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.author,
  });

  final int id;
  final int number;
  final String title;
  final DateTime createdAt;
  final String author;

  @override
  List<Object?> get props => [
        id,
        number,
        title,
        createdAt,
        author,
      ];
}

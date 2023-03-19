class IssueDTO {
  IssueDTO({
    required this.id,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.author,
  });

  final int id;
  final int number;
  final String title;
  final String createdAt;
  final String author;

  factory IssueDTO.fromJson(Map<String, dynamic> json) => IssueDTO(
        id: json['id'],
        number: json['number'],
        title: json['title'],
        createdAt: json['created_at'],
        author: json['user']['login'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'title': title,
        'created_at': createdAt,
        'author': author,
      };
}

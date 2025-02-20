class IssueDTO {
  const IssueDTO({
    required this.id,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.author,
    this.body,
    this.comments,
    this.labels,
  });

  final int id;
  final int number;
  final String title;
  final String createdAt;
  final String author;
  final String? body;
  final int? comments;
  final List<String>? labels;

  factory IssueDTO.fromJson(Map<String, dynamic> json) => IssueDTO(
        id: json['id'],
        number: json['number'],
        title: json['title'],
        createdAt: json['created_at'],
        author: json['user']['login'],
        body: json['body'],
        comments: json['comments'],
        labels: (json['labels'] as Iterable)
            .map((e) => e['name'] as String)
            .toList(growable: false),
      );
}

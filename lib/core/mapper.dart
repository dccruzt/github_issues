import '../data/dtos/issue_dto.dart';
import '../domain/entities/issue.dart';

mixin Mapper {
  Issue mapToIssueEntity(IssueDTO from);
}

class MapperImpl implements Mapper {
  @override
  Issue mapToIssueEntity(IssueDTO from) => Issue(
        id: from.id,
        number: from.number.toString(),
        title: from.title,
        createdAt: DateTime.tryParse(from.createdAt) ?? DateTime.now(),
        author: from.author,
        body: from.body,
        comments: from.comments,
        labels: from.labels,
        visited: false,
      );
}

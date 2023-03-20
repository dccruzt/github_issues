import '../data/dto/issue_dto.dart';
import '../domain/entity/issue_entity.dart';

mixin Mapper {
  IssueEntity mapToIssueEntity(IssueDTO from);
}

class MapperImpl implements Mapper {
  @override
  IssueEntity mapToIssueEntity(IssueDTO from) => IssueEntity(
        id: from.id,
        number: from.number,
        title: from.title,
        createdAt: DateTime.tryParse(from.createdAt) ?? DateTime.now(),
        author: from.author,
        body: from.body,
        labels: from.labels,
      );
}

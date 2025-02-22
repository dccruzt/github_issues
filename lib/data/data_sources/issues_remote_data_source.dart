import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/data_sources/issues_remote_data_source.dart';
import '../dtos/issue_dto.dart';

class IssuesRemoteDataSourceImpl implements IssuesRemoteDataSource {
  String get _url => 'api.github.com';

  @override
  Future<List<IssueDTO>> getIssues() async {
    try {
      final url = Uri.https(
        _url,
        'repos/flutter/flutter/issues',
        {'per_page': '10'},
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Iterable;
        return json
            .map((issue) => IssueDTO.fromJson(issue))
            .toList(growable: false);
      }
      throw Exception();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<IssueDTO> getIssue(String number) async {
    try {
      final url = Uri.https(_url, 'repos/flutter/flutter/issues/$number');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return IssueDTO.fromJson(json);
      }
      throw Exception();
    } catch (_) {
      rethrow;
    }
  }
}

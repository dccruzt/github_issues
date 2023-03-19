import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/issue_dto.dart';

class IssuesRemoteDataSource {
  Future<List<IssueDTO>> getIssues() async {
    try {
      final url = Uri.https('api.github.com', 'repos/flutter/flutter/issues');
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
}

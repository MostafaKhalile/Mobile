import 'dart:convert';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/models/client/company.dart';

abstract class CompaniesRepository {
  /// Throws [NetworkException].
  Future<List<Company>> fetchCompaniesList(int id);
}

class APICompaniesRepository implements CompaniesRepository {
  @override
  Future<List<Company>> fetchCompaniesList(int id) async {
    final response = await http.post(
      "$KAPIURL$KCompaniesList$id",
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Company.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('${json.decode(response.body)}');
    }
  }
}

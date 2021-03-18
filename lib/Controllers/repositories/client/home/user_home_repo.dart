import 'dart:convert';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/models/client/advertise.dart';
import 'package:techtime/models/client/category.dart';
import 'package:techtime/models/client/company.dart';

abstract class ClientHomeRepository {
  /// Throws [NetworkException].
  Future<List<Category>> get fetchCategories;
  Future<List<Company>> get fetchRecommendedCo;
  Future<List<Advertise>> get fetchAdsAbove;
  Future<List<Company>> get fetchLeastCo;
}

//  headers: {
//       HttpHeaders.authorizationHeader:
//           "Token 8483e30d2158a5a78746f88c9fbd119057faa5cc"
//     },

class APIClientHomeRepository implements ClientHomeRepository {
  Future<List<Category>> get fetchCategories async {
    final response = await http.post(
      KAPIURL + KHomeAllCategories,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Category.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('${json.decode(response.body)}');
    }
  }

  Future<List<Company>> get fetchRecommendedCo async {
    final response = await http.post(
      KAPIURL + KHomeRecommendedCo,
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

  Future<List<Advertise>> get fetchAdsAbove async {
    final response = await http.post(KAPIURL + KHomeAdsAbove,
        body: {"RequestType": "API", "LanguageCode": "EN"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Advertise.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('${json.decode(response.body)['message']}');
    }
  }

  Future<List<Company>> get fetchLeastCo async {
    final response = await http.post(
      KAPIURL + KHomeRecommendedCo,
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

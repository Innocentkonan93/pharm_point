import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/villes.dart';

class AllVilles {
  static const String url = 'http://bad-event.com/pharma/getVille.php';

  static Future<List<Villes>> getVilless() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Villes> list = parseVilless(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static List<Villes> parseVilless(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Villes>((json) => Villes.fromJson(json)).toList();
  }
}

class AllPharms {
  static const String url =
      'http://192.168.64.2/Projects/pharma_/getPharm2.php';

  static Future<List<Pharms>> getPharms() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Pharms> list = parsePharms(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static List<Pharms> parsePharms(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pharms>((json) => Pharms.fromJson(json)).toList();
  }
}

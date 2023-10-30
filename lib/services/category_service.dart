import 'dart:convert';

import 'package:mobile_app_demo/utils/api_util.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<dynamic>> fetchAll() async {
    try {
      var res = await http.get(
          Uri.parse(
            "${ApiUtil.domain}/Category",
          ),
          headers: {'Content-Type': 'application/json'});

      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body) as List<dynamic>;
      } else {
        print('Something went wrong');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> save({
    required String name,
    required String description,
  }) async {
    try {
      var res = await http.post(
          Uri.parse(
            "${ApiUtil.domain}/Category",
          ),
          body: jsonEncode({
            "name": name,
            "description": description,
          }),
          headers: {
            'Content-Type': 'application/json',
          });

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> softDeleteById(int id) async {
    try {
      var res = await http.delete(Uri.parse(
        "${ApiUtil.domain}/Category/soft/$id",
      ));

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteById(int id) async {
    try {
      var res = await http.delete(Uri.parse(
        "${ApiUtil.domain}/Category/$id",
      ));

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> update(
      {required dynamic category, required int id}) async {
    try {
      var res = await http.put(
        Uri.parse(
          "${ApiUtil.domain}/Category/$id",
        ),
        body: jsonEncode({
          'name': category['name'],
          'description': category['description'],
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }
}

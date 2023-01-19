import 'package:dio/dio.dart';
import 'package:flutter_suitmedia/model/model_data.dart';

class Api {
  Future<List<Data>> getData(int page, int limit) async {
    try {
      var response =
          await Dio().get('https://reqres.in/api/users?limit=$limit&per_page=$page');
      print(response);
      final data = ((response.data['data'] ?? []) as List)
          .map((e) => Data.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

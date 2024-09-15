import 'package:dio/dio.dart';
import 'package:news_app/Models/all_news_model.dart';

class ApiService {
  final String apiKey = "ae70f501447e4095826bee9bae10ff45";

  Future<AllNewsModel> getAllNews({String? query = "economy"}) async {
    final response = await Dio()
        .get("https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey");

    if (response.statusCode == 200) {
      return AllNewsModel.fromJson(response.data);
    } else {
      throw Exception("Failed to load NEWS!");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:news_app/Models/all_news_model.dart';

class ApiService {
  final String apiKey = "YOUR_API_TOKEN";

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

import 'package:flutter/material.dart';
import 'package:news_app/API%20Service/api_service.dart';
import 'package:news_app/Models/all_news_model.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  AllNewsModel? _allNewsModel;

  AllNewsModel? get allNewsModel => _allNewsModel;

  bool isLoading = false;

  Future<void> provideAllNews({String? query = "Economy"}) async {
    isLoading = true;
    notifyListeners();

    final news = await _apiService.getAllNews(query: query);
    _allNewsModel = news;

    isLoading = false;
    notifyListeners();
  }
}

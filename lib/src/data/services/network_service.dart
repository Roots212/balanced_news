import 'dart:convert';

import 'package:balanced_news/src/data/models/news_model.dart';
import 'package:http/http.dart';

class NetworkServices {
  Future<NewsModel?> fetchPosts(String category) async {
    final baseUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=548106954f884f4d85d7b95218ed3aa1';
    try {
      final response = await get(Uri.parse(baseUrl));
      print(response.body);
      NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
      return newsModel;
    } catch (e) {
      return null;
    }
  }

  fetchCategoryData(String category) async {
    final baseUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=548106954f884f4d85d7b95218ed3aa1';
    try {
      final response = await get(Uri.parse(baseUrl));
      print(response.body);
      NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
      return newsModel;
    } catch (e) {
      return null;
    }
  }

  Future<NewsModel?> searchData(String keyword) async {
    final baseUrl =
        'https://newsapi.org/v2/everything?q=$keyword&apiKey=548106954f884f4d85d7b95218ed3aa1';
    try {
      final response = await get(Uri.parse(baseUrl));
      print(response.body);
      NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
      return newsModel;
    } catch (e) {
      return null;
    }
  }
}

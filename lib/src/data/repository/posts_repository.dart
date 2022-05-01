
import 'package:balanced_news/src/data/models/news_model.dart';
import 'package:balanced_news/src/data/services/network_service.dart';

class PostRepository {
  NetworkServices networkServices=NetworkServices();
  Future<NewsModel?> fetchPostsData(String category) async {
    final posts = await networkServices.fetchPosts(category);
    return posts;
  }

  Future<NewsModel?> searchNews(String query) async {
    final posts = await networkServices.searchData(query);
    return posts;
  }
}

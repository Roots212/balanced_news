import 'package:balanced_news/src/data/models/news_model.dart';
import 'package:balanced_news/src/data/repository/posts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'searchnews_state.dart';

class SearchnewsCubit extends Cubit<SearchnewsState> {
  SearchnewsCubit() : super(SearchnewsInitial());
  PostRepository postRepository = PostRepository();


    void searchPosts(String query) {
    emit(SearchnewsLoading());
    postRepository.searchNews(query).then((value) {
      if (value == null) {
      } else {
        if (value.articles!.isNotEmpty) {
          emit(SearchnewsLoadSuccess( newsModel: value));
        } else {
          emit(SearchnewsNoData());
        }
      }
    });
  }
}

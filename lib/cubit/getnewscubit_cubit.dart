import 'package:balanced_news/src/data/models/news_model.dart';
import 'package:balanced_news/src/data/models/wikipedia_model.dart';
import 'package:balanced_news/src/data/repository/posts_repository.dart';
import 'package:balanced_news/src/data/services/network_service.dart';
import 'package:bloc/bloc.dart';

part 'getnewscubit_state.dart';

class GetnewscubitCubit extends Cubit<GetnewscubitState> {
  GetnewscubitCubit(this._category) : super(GetnewscubitInitial());
  String _category;
  String get category => _category;
  NetworkServices networkServices = NetworkServices();
  PostRepository postRepository = PostRepository();

  set category(String category) {
    _category = category;
    fetchPosts();
  }

  void fetchPosts() {
    emit(GetnewscubitLoading());
    postRepository.fetchPostsData(_category).then((value) {
      print(category);
      emit(GetnewscubitLoaded(value!));
    });
  }
}

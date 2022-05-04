import 'package:balanced_news/src/data/models/wikipedia_model.dart';
import 'package:balanced_news/src/data/repository/posts_repository.dart';
import 'package:balanced_news/src/data/services/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orgdata_state.dart';

class OrgdataCubit extends Cubit<OrgdataState> {
  OrgdataCubit() : super(OrgdataInitial());

  NetworkServices networkServices = NetworkServices();
  PostRepository postRepository = PostRepository();

  Future<void> fetchDetails(String query) async {
    emit(GetorgsLoading());
    try {
      final val = await postRepository.fetchDetails(query);
      print(val);
      emit(GetOrgsLoaded(wkiModel: val));
    } catch (e) {
      emit(GetorgscubitError());
    }
  }
}

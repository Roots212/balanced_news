part of 'searchnews_cubit.dart';

abstract class SearchnewsState extends Equatable {
  const SearchnewsState();

  @override
  List<Object> get props => [];
}

class SearchnewsInitial extends SearchnewsState {}
class SearchnewsLoading extends SearchnewsState {}
class SearchnewsLoadSuccess extends SearchnewsState {
    final NewsModel newsModel;

  SearchnewsLoadSuccess({required this.newsModel});

}
class SearchnewsNoData extends SearchnewsState {}

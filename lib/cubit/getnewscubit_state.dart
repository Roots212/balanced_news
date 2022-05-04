part of 'getnewscubit_cubit.dart';

abstract class GetnewscubitState {}

class GetnewscubitInitial extends GetnewscubitState {}

class GetnewscubitLoading extends GetnewscubitState {}

class GetnewscubitLoaded extends GetnewscubitState {
  final NewsModel newsModel;

  GetnewscubitLoaded(this.newsModel);
}

class GetnewscubitError extends GetnewscubitState {}

class GetnewscubitEmpty extends GetnewscubitState {}

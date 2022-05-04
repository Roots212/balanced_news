// ignore_for_file: prefer_const_constructors_in_immutables

part of 'orgdata_cubit.dart';

abstract class OrgdataState extends Equatable {
  const OrgdataState();

  @override
  List<Object> get props => [];
}

class OrgdataInitial extends OrgdataState {}

class GetOrgsLoaded extends OrgdataState {
  final WikiPediaModel? wkiModel;

  GetOrgsLoaded({required this.wkiModel});
}

class GetorgsLoading extends OrgdataState {}

class GetorgscubitError extends OrgdataState {}

part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
    final String username;
  final String imgurl;

  LoginSuccess({required this.username,required this.imgurl});
}

class LoginFail extends LoginState {}

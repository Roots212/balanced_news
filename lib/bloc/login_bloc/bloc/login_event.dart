// ignore_for_file: prefer_const_constructors_in_immutables

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
    LoginEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}




class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}
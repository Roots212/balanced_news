import 'package:balanced_news/src/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginWithGooglePressed>(_mapLoginWithGooglePressedToState);
    on<LoginWithCredentialsPressed>(_mapLoginWithCredentialsPressedToState);
    on<SendEmailForLogin>(_mapSendEmailForLoginState);
    on<SigninWithEmail>(_mapSigninWithEmailState);
  }
  UserRepository userRepository = UserRepository();

  _mapLoginWithGooglePressedToState(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());

    try {
      final user = await userRepository.signInWithGoogle();
      emit(LoginSuccess(username: user.displayName!, imgurl: user.photoURL!));
    } catch (e) {
      print(e);
      emit.isDone ? emit(LoginFail()) : print('wait');
    }
  }

  _mapSendEmailForLoginState(
      SendEmailForLogin event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
      await userRepository.sendEmailLink(email: event.email).then((value) {
        emit(LoginEmailSent(email: event.email));
      });
    } catch (_) {
      emit(LoginFail());
    }
  }

  _mapSigninWithEmailState(
      SigninWithEmail event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
      await userRepository
          .signupWithEmail(email: event.email, link: event.link)
          .then((value) {
        emit(LoginSuccess(
            imgurl: 'https://ui-avatars.com/api/?name=${event.email}',
            username: event.email));
      });
    } catch (_) {
      emit(LoginFail());
    }
  }

  _mapLoginWithCredentialsPressedToState(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
      final user = await userRepository.signUp(
          password: event.password, email: event.email);
      emit(LoginSuccess(
          username: user.user!.displayName!, imgurl: user.user!.photoURL!));
    } catch (_) {
      emit(LoginFail());
    }
  }
}

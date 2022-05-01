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
  }
  UserRepository userRepository = UserRepository();

  _mapLoginWithGooglePressedToState(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());

    try {
     final user= await userRepository.signInWithGoogle();
      emit(LoginSuccess(
        username: user.displayName!,imgurl: user.photoURL!
      ));
    } catch (e) {
      print(e);
      emit.isDone ? emit(LoginFail()) : print('wait');
    }
  }

  _mapLoginWithCredentialsPressedToState(LoginWithCredentialsPressed event,
      Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    try {
       final user= await userRepository.signUp(password: event.password, email: event.email);
      emit(LoginSuccess(
        username: user.user!.displayName!,
        imgurl: user.user!.photoURL!
      ));
    } catch (_) {
      emit(LoginFail());
    }
  }
}

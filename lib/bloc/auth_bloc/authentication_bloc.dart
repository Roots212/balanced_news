// ignore_for_file: prefer_final_fields

import 'package:balanced_news/src/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
  }
  final UserRepository userRepository;

  Future<void> _mapAppStartedToState(AuthenticationEvent authenticationEvent,
      Emitter<AuthenticationState> emit) async {
    print('in App Statred');
    try {
      final isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        print(isSignedIn);
        final name = await userRepository.getUser();
        final photoUrl = await userRepository.getUserPhoto(name);
        emit(Authenticated(displayName: name, imgUrl: photoUrl));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _mapLoggedInToState(
      LoggedIn authenticationEvent, Emitter<AuthenticationState> emit) async {
    final name = await userRepository.getUser();
    final photoUrl = await userRepository.getUserPhoto(name);
    emit(Authenticated(displayName: name, imgUrl: photoUrl));
  }

  Future<void> _mapLoggedOutToState(
      LoggedOut authenticationEvent, Emitter emit) async {
    userRepository.signOut();
    print('logout');

    emit(Unauthenticated());
    
  }
}

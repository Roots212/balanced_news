import 'package:balanced_news/bloc/auth_bloc/authentication_bloc.dart';
import 'package:balanced_news/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/cubit/search/searchnews_cubit.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_home_screen.dart';
import 'package:balanced_news/src/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'src/data/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({
    Key? key,
  }) : super(key: key);

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  final UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
                BlocProvider<SearchnewsCubit>(create: (BuildContext context) => SearchnewsCubit()),

        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AppStarted())),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
            title: 'Balanced News',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen());
      }),
    );
  }
}
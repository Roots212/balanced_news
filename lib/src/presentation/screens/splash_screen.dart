// ignore_for_file: prefer_const_constructors

import 'package:balanced_news/bloc/auth_bloc/authentication_bloc.dart';
import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/src/data/repository/user_repository.dart';
import 'package:balanced_news/src/presentation/screens/auth/sign_in_screen.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_home_screen.dart';
import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:balanced_news/src/presentation/widgets/title_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => BlocProvider<GetnewscubitCubit>(
                          create: (context) => GetnewscubitCubit('general'),
                          child: NewsHomeScreen(imgurl: state.imgUrl,username: state.displayName,),
                        ))));
          });
        } else if (state is Unauthenticated) {
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => SignInScreen(
                          userRepository: userRepository,
                        ))));
          });
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(6.0.w, 0.0, 6.0.w, 0.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 100,
              )
            ]),
            child: Hero(
              tag: 'title_hero',
              child: TitleWidget(
                padding: EdgeInsets.all(2.0.w),
                fontsize: 35.0.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

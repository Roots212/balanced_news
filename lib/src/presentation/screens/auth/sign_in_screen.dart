// ignore_for_file: avoid_print

import 'package:balanced_news/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/src/data/repository/user_repository.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_home_screen.dart';
import 'package:balanced_news/src/presentation/utils/validators.dart';
import 'package:balanced_news/src/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.userRepository})
      : super(key: key);
  final UserRepository userRepository;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Hero(
            tag: 'title_hero',
            child: TitleWidget(
              padding: EdgeInsets.fromLTRB(2.0.w, 0.0, 1.0.w, 0.0),
              fontsize: 15.0.sp,
            )),
      ),
      body: SizedBox(
        height: 100.0.h,
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0.h,
                child: SvgPicture.asset(
                  'assets/svg/signup.svg',
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Login',
                style: TextStyle(
                    color: CustomColors.activeColor,
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: CustomColors.secondarybackGroundColor,
                thickness: 2.0.sp,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              formBody()
            ],
          ),
        ),
      ),
    );
  }

  Widget formBody() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
              autocorrect: false,
              validator: (val) {
                return Validators.isValidEmail(val!);
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
              autocorrect: false,
              validator: (val) {
                return Validators.isValidPassword(val!);
              },
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  print('success');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              BlocProvider<GetnewscubitCubit>(
                                create: (context) =>
                                    GetnewscubitCubit('general'),
                                child:  NewsHomeScreen(imgurl:state.imgurl,username: state.username,),
                              ))));
                }
              },
              builder: (context, state) {
                if (state is LoginInProgress) {
                  return const CircularProgressIndicator();
                } else {
                  return RawMaterialButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginWithGooglePressed());
                    },
                    child: const Text('Google'),
                  );
                }
              },
            )
          ],
        ));
  }
}

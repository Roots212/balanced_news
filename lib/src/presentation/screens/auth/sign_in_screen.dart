// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:balanced_news/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/src/data/repository/user_repository.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_home_screen.dart';
import 'package:balanced_news/src/presentation/utils/validators.dart';
import 'package:balanced_news/src/presentation/widgets/title_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void initState() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      BlocProvider.of<LoginBloc>(context).add(SigninWithEmail(
          link: dynamicLinkData.link.toString(), email: _emailController.text));
    }).onError((error) {
      // Handle errors
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                "Let's Sign you in.",
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
    return kIsWeb
        ? Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColors.secondarybackGroundColor,
                      borderRadius: BorderRadius.circular(5.0.sp),
                      border:
                          Border.all(color: CustomColors.tabBackGroundColor)),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // ignore: prefer_const_constructors
                      suffixIcon: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginEmailSent) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Email sent on ${state.email}')));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginInProgress) {
                            // ignore: prefer_const_constructors
                            return Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                if (Validators.isValidEmail(
                                    _emailController.text)) {
                                  print('valid');
                                  BlocProvider.of<LoginBloc>(context).add(
                                      SendEmailForLogin(
                                          email: _emailController.text));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Email not in correct format')));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(1.0.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0.sp),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: CustomColors.backGroundColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),

                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.2)),
                      contentPadding:
                          EdgeInsets.fromLTRB(2.0.h, 3.0.h, 2.0.h, 0.0),
                      hintText: 'Passwordless Sign-in, just enter your email',
                    ),
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    validator: (val) {
                      return Validators.isValidEmail(val!);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0.w,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: CustomColors.activeColor,
                      fontSize: 5.0.sp,
                      fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 5.0.h,
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
                                    child: NewsHomeScreen(
                                      imgurl: state.imgurl,
                                      username: state.username,
                                    ),
                                  ))));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginInProgress) {
                      return Padding(
                        padding: EdgeInsets.all(2.0.w),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return RawMaterialButton(
                        constraints: BoxConstraints(maxWidth: 50.0.w),
                        fillColor: CustomColors.secondarybackGroundColor,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginWithGooglePressed());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: 20.0.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4.0.w,
                              ),
                              Text(
                                'Google',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ))
        : Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColors.secondarybackGroundColor,
                      borderRadius: BorderRadius.circular(5.0.sp),
                      border:
                          Border.all(color: CustomColors.tabBackGroundColor)),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // ignore: prefer_const_constructors
                      suffixIcon: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginEmailSent) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Email sent on ${state.email}')));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginInProgress) {
                            // ignore: prefer_const_constructors
                            return Padding(
                              padding: EdgeInsets.all(2.0.w),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                if (Validators.isValidEmail(
                                    _emailController.text)) {
                                  print('valid');
                                  BlocProvider.of<LoginBloc>(context).add(
                                      SendEmailForLogin(
                                          email: _emailController.text));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Email not in correct format')));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(1.0.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0.sp),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: CustomColors.backGroundColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),

                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.2)),
                      contentPadding:
                          EdgeInsets.fromLTRB(2.0.w, 3.0.w, 2.0.w, 0.0),
                      hintText: 'Passwordless Sign-in, just enter your email',
                    ),
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    validator: (val) {
                      return Validators.isValidEmail(val!);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: CustomColors.activeColor,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 5.0.h,
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
                                    child: NewsHomeScreen(
                                      imgurl: state.imgurl,
                                      username: state.username,
                                    ),
                                  ))));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginInProgress) {
                      return Padding(
                        padding: EdgeInsets.all(2.0.w),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return RawMaterialButton(
                        constraints: BoxConstraints(maxWidth: 50.0.w),
                        fillColor: CustomColors.secondarybackGroundColor,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginWithGooglePressed());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: 20.0.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4.0.w,
                              ),
                              Text(
                                'Google',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ));
  }
}

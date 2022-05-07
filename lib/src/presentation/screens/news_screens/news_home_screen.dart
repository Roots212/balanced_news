// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balanced_news/bloc/auth_bloc/authentication_bloc.dart';
import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/src/presentation/screens/auth/sign_in_screen.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/analytics_page.dart';
import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_screen.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/search_news_screen.dart';
import 'package:balanced_news/src/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';

class NewsHomeScreen extends StatefulWidget {
  final String username;
  final String imgurl;
  const NewsHomeScreen({Key? key, required this.username, required this.imgurl})
      : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

int _selectedIndex = 0;

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  PageController pageController = PageController(initialPage: _selectedIndex);

  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return SizerUtil.deviceType == DeviceType.mobile
        ? SafeArea(
            child: Scaffold(
              backgroundColor: CustomColors.backGroundColor,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: CustomColors.secondarybackGroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.white.withOpacity(0.2),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.0.w),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: CustomColors.activeColor,
                    iconSize: 15.0.sp,
                    color: CustomColors.activeColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    textStyle: TextStyle(color: CustomColors.activeColor),
                    tabBackgroundColor: CustomColors.tabBackGroundColor,
                    tabs: [
                      GButton(
                        icon: Icons.home_rounded,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.analytics_rounded,
                        text: 'Analytics',
                      ),
                      GButton(
                        icon: Icons.search_rounded,
                        text: 'Search',
                      ),
                    ],
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                        pageController.animateToPage(_selectedIndex,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      });
                    },
                    selectedIndex: _selectedIndex,
                  ),
                ),
              ),
              body: NestedScrollView(
                body: PageView(
                  controller: pageController,
                  pageSnapping: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    NewsScreen(),
                    BlocProvider(
                      create: (context) => GetnewscubitCubit('genereal'),
                      child: AnalyticsPage(),
                    ),
                    SearchNewsScreen(),
                  ],
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: false,
                      actions: [
                        SizedBox(
                          width: 50.0.w,
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0.sp),
                            child: Image.network(widget.imgurl),
                          ),
                        )
                      ],
                      floating: true,
                      backgroundColor: CustomColors.backGroundColor,
                      snap: false,
                      bottom: PreferredSize(
                          preferredSize: Size(100.0.w, 5.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.5.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back, ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0.sp),
                                    ),
                                    Text(
                                      widget.username.split('@')[0],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.0.sp),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0.w),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(LoggedOut());
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                SignInScreen())));
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: CustomColors.activeColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.0.sp),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      title: TitleWidget(
                        padding: EdgeInsets.fromLTRB(2.0.w, 0.0, 1.0.w, 0.0),
                        fontsize: 10.0.sp,
                      ),
                    )
                  ];
                },
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: CustomColors.backGroundColor,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: CustomColors.secondarybackGroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.white.withOpacity(0.2),
                    )
                  ],
                ),
                child: SafeArea(
                    child: Padding(
                  padding: EdgeInsets.all(1.0.w),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: CustomColors.activeColor,
                    iconSize: 6.0.sp,
                    color: CustomColors.activeColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    textStyle: TextStyle(color: CustomColors.activeColor),
                    tabBackgroundColor: CustomColors.tabBackGroundColor,
                    tabs: [
                      GButton(
                        icon: Icons.home_rounded,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.search_rounded,
                        text: 'Search',
                      ),
                    ],
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                        pageController.animateToPage(_selectedIndex,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      });
                    },
                    selectedIndex: _selectedIndex,
                  ),
                )),
              ),
              appBar: AppBar(
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(1.0.w, 0.0, 1.0.w, 0.0),
                      decoration: BoxDecoration(
                          color: CustomColors.activeColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(0))),
                      child: Text(
                        'Balanced',
                        style: TextStyle(
                            fontSize: 6.0.sp,
                            color: CustomColors.secondarybackGroundColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(1.0.w, 0.0, 1.0.w, 0.0),
                      decoration: BoxDecoration(
                          color: CustomColors.secondarybackGroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(2),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(2))),
                      child: Text(
                        'News',
                        style: TextStyle(
                            fontSize: 6.0.sp, color: CustomColors.activeColor),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: PageView(
                controller: pageController,
                pageSnapping: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  NewsScreen(),
                  SearchNewsScreen(),
                ],
              ),
            ),
          );
  }
}

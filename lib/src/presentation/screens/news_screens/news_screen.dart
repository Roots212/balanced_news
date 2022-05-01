// ignore: prefer_const_constructors

// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:balanced_news/src/presentation/widgets/list_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

int selectedTab = 0;

class _NewsScreenState extends State<NewsScreen>
    with
        AutomaticKeepAliveClientMixin<NewsScreen>,
        SingleTickerProviderStateMixin {
  SwiperController swiperController = SwiperController();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);

    BlocProvider.of<GetnewscubitCubit>(context).fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          backgroundColor: CustomColors.backGroundColor,
          appBar: TabBar(
            isScrollable: true,
            controller: tabController,
            indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 3.0, color: CustomColors.activeColor),
                insets: EdgeInsets.symmetric(horizontal: 10.0)),
            indicatorWeight: 5.0,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.fromLTRB(1.0.w, 0.0, 1.0.w, 0),
            padding: EdgeInsets.all(0.5.w),
            labelColor: CustomColors.activeColor,
            unselectedLabelColor: Colors.white,
            onTap: (int index) {
              print(index);
              if (index == 0) {
                BlocProvider.of<GetnewscubitCubit>(context).category =
                    'general';
              } else if (index == 1) {
                BlocProvider.of<GetnewscubitCubit>(context).category =
                    'business';
              } else if (index == 2) {
                BlocProvider.of<GetnewscubitCubit>(context).category =
                    'entertainment';
              } else if (index == 3) {
                BlocProvider.of<GetnewscubitCubit>(context).category = 'sports';
              } else if (index == 4) {
                BlocProvider.of<GetnewscubitCubit>(context).category =
                    'technology';
              } else if (index == 5) {
                BlocProvider.of<GetnewscubitCubit>(context).category = 'health';
              } else if (index == 6) {
                BlocProvider.of<GetnewscubitCubit>(context).category =
                    'science';
              }
            },
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              Tab(
                text: 'All News',
              ),
              Tab(
                text: 'Business',
              ),
              Tab(
                text: 'Entertainment',
              ),
              Tab(
                text: 'Sports',
              ),
              Tab(
                text: 'Technology',
              ),
              Tab(
                text: 'Health',
              ),
              Tab(
                text: 'Science',
              ),
            ],
          ),
          body: BlocBuilder<GetnewscubitCubit, GetnewscubitState>(
            builder: (context, state) {
              if (state is GetnewscubitLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: CustomColors.activeColor,
                ));
              }

              final newsData = (state as GetnewscubitLoaded).newsModel;
              return TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                  NewsListWidget(newsModel: newsData),
                ],
              );
            },
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

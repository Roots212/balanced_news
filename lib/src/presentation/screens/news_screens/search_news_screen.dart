// ignore_for_file: avoid_unnecessary_containers

import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/cubit/search/searchnews_cubit.dart';
import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:balanced_news/src/presentation/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'news_detailScreen.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  _SearchNewsScreenState createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  TextEditingController searchontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    // ignore: prefer_const_constructors
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.backGroundColor,
        body: BlocBuilder<SearchnewsCubit, SearchnewsState>(
            builder: (context, state) {
          if (state is SearchnewsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: CustomColors.activeColor,
            ));
          } else if (state is SearchnewsLoadSuccess) {
            final newsModel = (state).newsModel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.0.w),
                    child: TextFormField(
                      style: TextStyle(
                          color: CustomColors.activeColor,
                          fontFamily: 'ProductSans',
                          fontSize: 11.0.sp),
                      controller: searchontroller,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Type Something';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (val) {
                        print(val);
                        BlocProvider.of<SearchnewsCubit>(context)
                            .searchPosts(val);
                      },
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      inputFormatters: const [
                        // LengthLimitingTextInputFormatter(30),
                      ],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search_rounded,
                            color: CustomColors.activeColor,
                          ),
                          onPressed: () {},
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0.sp),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0.sp),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0.sp),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0.sp),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 25, 67, 87),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  SizedBox(
                    height: 74.0.h,
                    child: NewsListWidget(newsModel: newsModel)
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(3.0.w),
                  child: TextFormField(
                    style: TextStyle(
                        color: CustomColors.activeColor,
                        fontFamily: 'ProductSans',
                        fontSize: 11.0.sp),
                    controller: searchontroller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Type Something';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (val) {
                      print(val);
                      BlocProvider.of<SearchnewsCubit>(context)
                          .searchPosts(val);
                    },
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    inputFormatters: const [
                      // LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search_rounded,
                          color: CustomColors.activeColor,
                        ),
                        onPressed: () {},
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.sp),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.sp),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.sp),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.sp),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 25, 67, 87),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Center(
                  child: Icon(
                    Icons.youtube_searched_for,
                    size: 200.0.sp,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ]),
            );
          }
        }));
  }
}

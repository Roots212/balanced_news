import 'package:balanced_news/src/data/models/news_model.dart';
import 'package:balanced_news/src/presentation/screens/news_screens/news_detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewsListWidget extends StatelessWidget {
  final NewsModel newsModel;
  const NewsListWidget({Key? key, required this.newsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return SizedBox(
      height: 100.0.h,
      width: 100.0.w,
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => NewsDetailPage(
                            content: newsModel.articles![index].description!,
                            url: newsModel.articles![index].url!,
                            title: newsModel.articles![index].title!,
                            imgUrl: newsModel.articles![index].urlToImage!,
                            time: ((DateTime.parse(newsModel.articles![index].publishedAt!)
                                            .difference(DateTime.now())
                                            .inHours)
                                        .abs() <
                                    24
                                ? ((DateTime.parse(newsModel.articles![index].publishedAt!)
                                            .difference(DateTime.now())
                                            .inHours)
                                        .abs()
                                        .toString()) +
                                    ' hours ago'
                                : ((DateTime.parse(
                                                newsModel.articles![index].publishedAt!)
                                            .difference(DateTime.now())
                                            .inDays)
                                        .abs()
                                        .toString()) +
                                    ' days ago'),
                            source: newsModel.articles![index].source!.name!))));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0.sp),
                    child: Image.network(newsModel
                            .articles![index].urlToImage ??
                        'https://images.unsplash.com/photo-1484069560501-87d72b0c3669?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0.w),
                    child: Text(
                      newsModel.articles![index].title!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 2.0.h,
            );
          },
          itemCount: newsModel.articles!.length),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'dart:io';

import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsDetailPage extends StatefulWidget {
  final String content;
  final String title;
  final String imgUrl;
  final String time;
  final String source;
  final String url;

  const NewsDetailPage(
      {Key? key,
      required this.content,
      required this.title,
      required this.imgUrl,
      required this.time,
      required this.source,
      required this.url})
      : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: CustomColors.activeColor,
          onPressed: kIsWeb
              ? () {
                }
              : () {
                  showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Scaffold(
                            appBar: AppBar(
                              backgroundColor: CustomColors.backGroundColor,
                            ),
                            body: SizedBox(
                              height: 80.0.h,
                              child: WebView(
                                javascriptMode: JavascriptMode.disabled,
                                initialUrl: widget.url,
                              ),
                            ),
                          ),
                        );
                      });
                },
          label: Text(
            'Full news',
            style: TextStyle(
                color: CustomColors.backGroundColor, fontSize: 13.0.sp),
          )),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close_rounded,
              color: CustomColors.activeColor, size: 25.0.sp),
        ),
        title: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SizedBox(
        width: 100.0.w,
        height: 100.0.h,
        child: Stack(
          children: [
            Container(
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.multiply),
                    child: SizedBox(
                      height: 55.0.h,
                      child: Image.network(
                        widget.imgUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 100.0.w,
                        child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(5.0.w, 0.0.h, 0.0, 15.0.w),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w300),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(top: 50.0.h),
                padding: EdgeInsets.all(3.0.w),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.white.withOpacity(0.3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0.sp),
                        topRight: Radius.circular(15.0.sp)),
                    color: CustomColors.secondarybackGroundColor),
                child: MediaQuery.removePadding(
                  context: context,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Source: ' + widget.source,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w300,
                                wordSpacing: 0.5.w),
                          ),
                          Spacer(),
                          Text(
                            widget.time,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w300,
                                wordSpacing: 0.5.w),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Text(
                        widget.content,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w300,
                            wordSpacing: 2.0.w),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:balanced_news/cubit/getnewscubit_cubit.dart';
import 'package:balanced_news/cubit/org_data/orgdata_cubit.dart';
import 'package:balanced_news/src/data/models/news_data_model.dart';
import 'package:balanced_news/src/data/models/wikipedia_model.dart';
import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  List<NewsArticlesData> chartData = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    SizerUtil().toString();
    Stream<QuerySnapshot> articles = FirebaseFirestore.instance
        .collection(_firebaseAuth.currentUser!.uid)
        .snapshots();
    return Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: StreamBuilder<QuerySnapshot>(
            stream: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                chartData = List.generate(snapshot.data!.docs.length, (index) {
                  return NewsArticlesData(
                      snapshot.data!.docs[index].id.toString(),
                      snapshot.data!.docs[index]['url'].length);
                });
              }
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return SfCircularChart(
                onSelectionChanged: (selectionArgs) {
                  BlocProvider.of<OrgdataCubit>(context)
                      .fetchDetails(chartData[selectionArgs.pointIndex].x);
                  print(selectionArgs.pointIndex);
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      enableDrag: false,
                      builder: (BuildContext context) {
                        return Container(height: 8.0.h, child: infoWidget());
                      });
                },
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(
                    isVisible: true,
                    textStyle: TextStyle(color: CustomColors.activeColor)),
                title: ChartTitle(
                    text: 'News Data',
                    textStyle: TextStyle(
                      color: Colors.white,
                    )),
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<NewsArticlesData, String>(
                      dataSource: chartData,
                      enableTooltip: true,
                      xValueMapper: (NewsArticlesData data, _) => data.x,
                      selectionBehavior: SelectionBehavior(enable: true),
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          color: CustomColors.activeColor,
                          // Positioning the data label
                          labelPosition: ChartDataLabelPosition.outside),
                      yValueMapper: (NewsArticlesData data, _) => data.y)
                ],
              );
            }));
  }

  Widget infoWidget() {
    return BlocBuilder<OrgdataCubit, OrgdataState>(builder: (context, state) {
      if (state is GetorgsLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: CustomColors.activeColor,
          ),
        );
      } else if (state is GetOrgsLoaded) {
        return Html(data: state.wkiModel!.query.search[0].snippet);
      } else {
        return Text('Error');
      }
    });
  }
}

import 'package:balanced_news/src/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double fontsize;
  const TitleWidget({Key? key, required this.padding, required this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: padding,
            decoration: const BoxDecoration(
                color: CustomColors.activeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(0))),
            child: Text(
              'Balanced',
              style: TextStyle(
                  fontSize: fontsize,
                  color: CustomColors.secondarybackGroundColor),
            ),
          ),
          Container(
            padding: padding,
            decoration: const BoxDecoration(
                color: CustomColors.secondarybackGroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(2),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(2))),
            child: Text(
              'News',
              style: TextStyle(
                  fontSize: fontsize, color: CustomColors.activeColor),
            ),
          ),
        ],
      ),
    );
  }
}

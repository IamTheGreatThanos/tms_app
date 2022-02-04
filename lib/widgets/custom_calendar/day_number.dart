import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'utils/screen_sizes.dart';

class DayNumber extends StatelessWidget {
  const DayNumber({
    Key? key,
    required this.day,
    required this.isLastDay,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final int day;
  final Color? color;
  final bool isLastDay;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final double size = getDayNumberSize(context);

    return Padding(
      padding: EdgeInsets.only(right: isLastDay ? 0 : 12.0),
      child: InkWell(
        onTap: () {
          if(day > 0) {
            onTap.call();
          }
        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: color != null ? 5 : 0, vertical: color != null ? 2 : 0),
          width: color != null ? 17 :13,
          height: color != null ? 17 :18,
          alignment: Alignment.center,
          decoration: color != null
              ? BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100),
                )
              : null,
          child: Text(
            day < 1 ? '' : day.toString(),
            textAlign: TextAlign.center,
            style: ProjectTextStyles.ui_12Medium.copyWith(color: color != null ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

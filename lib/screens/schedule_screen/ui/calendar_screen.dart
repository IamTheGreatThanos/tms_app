import 'dart:developer';

import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarScreen extends StatefulWidget {
  // final Function({
  //   DateTime? startTime,
  //   DateTime? endTime,
  // }) callback;
  const CalendarScreen({
    // required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    startTime = null;
    endTime = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Выберите дату',
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('assets/svg/icon_x.svg'),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // widget.callback(
        //       //   startTime: startTime,
        //       //   endTime: endTime,
        //       // );
        //       // Navigator.pop(context);
        //     },
        //     child: const Text(
        //       'Готово',
        //       style: TextStyle(
        //         color: ColorPalette.main,
        //         fontSize: 15,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SfDateRangePicker(
                headerStyle: const DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                yearCellStyle: const DateRangePickerYearCellStyle(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  viewHeaderHeight: 40,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                // todayHighlightColor: Colors.red,
                selectionColor: Colors.orange,
                startRangeSelectionColor: ColorPalette.main,
                endRangeSelectionColor: ColorPalette.main,
                rangeSelectionColor: Colors.green[100],

                // backgroundColor: Colors.grey,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    final DateTime? rangeStartDate = args.value.startDate;
                    final DateTime? rangeEndDate = args.value.endDate;
                    setState(() {
                      startTime = rangeStartDate;
                      endTime = rangeEndDate;
                    });
                    // log('${DateFormat('yyyy-MM-dd').format(rangeStartDate!)}, $rangeEndDate',
                    //     name: 'FilterCalendarScreen');
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${startTime != null ? DateFormat('yyyy-MM-dd').format(startTime!) : "__"} - ${endTime != null ? DateFormat('yyyy-MM-dd').format(endTime!) : "__"}',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

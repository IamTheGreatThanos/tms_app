import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? selectedDate;
  String? _startDate;
  String? _endDate;
  CalendarController calendarController = CalendarController();
  CalendarView? calendarView;

  @override
  void initState() {
    selectedDate = DateTime.now().subtract(Duration(days: 88));
    calendarView = CalendarView.month;
    super.initState();
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    _startDate = DateFormat('dd, MMMM yyyy')
        .format(viewChangedDetails.visibleDates[0])
        .toString();
    _endDate = DateFormat('dd, MMMM yyyy')
        .format(viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length - 1])
        .toString();

    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: 10,
          top: 180,
          right: 10,
          // bottom: 85,
          child: SizedBox(
            height: 500,
            child: SfCalendar(
              view: calendarView!,
              onViewChanged: (ViewChangedDetails viewChangedDetails) {
                SchedulerBinding.instance!.addPostFrameCallback((duration) {
                  setState(() {});
                });
              },
              headerDateFormat: "MMMM",
              monthViewSettings: const MonthViewSettings(
                numberOfWeeksInView: 6,
                showAgenda: true,
              ),
              controller: calendarController,
              onSelectionChanged: (details) {
                // getDaysInMonth(DateTime(2020, 5));
                print(DateTime(2022, 5)
                    .difference((DateTime(2022, 4)))
                    .inDays); //april
                calendarController.view = calendarView == CalendarView.month
                    ? CalendarView.day
                    : CalendarView.month;
                SchedulerBinding.instance!.addPostFrameCallback((duration) {
                  setState(() {});
                });
              },
              allowedViews: const [
                CalendarView.day,
                CalendarView.month,
              ],
              // monthCellBuilder:
              //     (BuildContext buildContext, MonthCellDetails details) {
              //   return Center(
              //     child: Text(
              //       details.date.day.toString(),
              //       // style: TextStyle(
              //       //     color: details.date.weekday == 6 ||
              //       //             details.date.weekday == 5
              //       //         ? Colors.red
              //       //         : Colors.black),
              //     ),
              //   );
              // }
            ),
            // child: SfCalendar(
            //   allowedViews: [
            //     CalendarView.day,
            //     CalendarView.week,
            //     CalendarView.workWeek,
            //     CalendarView.month,
            //     CalendarView.timelineDay,
            //     CalendarView.timelineWeek,
            //     CalendarView.timelineWorkWeek
            //   ],
            //   view: CalendarView.week,
            //   monthViewSettings: MonthViewSettings(showAgenda: true),
            //   onViewChanged: (ViewChangedDetails viewChangedDetails) {
            //     SchedulerBinding.instance!.addPostFrameCallback((duration) {
            //       setState(() {});
            //     });
            //   },
            //   // onViewChanged: viewChanged,
            // ),
          ),
        )
      ],
    ));
  }
}

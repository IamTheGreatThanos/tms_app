import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarController calendarController = CalendarController();
  CalendarView? calendarView;
  DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = DateTime.now().subtract(Duration(days: 88));
    calendarView = CalendarView.month;
    super.initState();
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
                  // SchedulerBinding.instance!.addPostFrameCallback((duration) {
                  //   setState(() {
                  //     calendarController.displayDate = DateTime.now().subtract(Duration(days: 33));
                  //     // getDaysInMonth(DateTime(2020, 5));
                  //     calendarController.view = calendarView == CalendarView.month
                  //         ? CalendarView.day
                  //         : CalendarView.month;
                  //   });
                  // });
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
          ),
          Positioned(
              bottom: 150,
              left: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  SchedulerBinding.instance!.addPostFrameCallback((duration) {
                    setState(() {
                      calendarController.displayDate = DateTime(2022, 1, 1);
                      calendarController.selectedDate = DateTime(2022, 1, 1);
                      // getDaysInMonth(DateTime(2020, 5));
                      calendarController.view =
                          calendarView == CalendarView.month
                              ? CalendarView.day
                              : CalendarView.month;
                    });
                  });
                },
                child: Text("CHANGE"),
              ))
        ],
      ),
    );
  }
}

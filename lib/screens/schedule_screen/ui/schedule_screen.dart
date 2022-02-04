import 'package:europharm_flutter/screens/full_calendar_screen/ui/full_calendar_screen.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/custom_calendar/scrolling_years_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    calendarView = CalendarView.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 67,
            right: 10,
            bottom: 85,
            child: SizedBox(
              child: SfCalendar(
                view: calendarView!,
                onViewChanged: (ViewChangedDetails viewChangedDetails) {
                  SchedulerBinding.instance!.addPostFrameCallback((duration) {
                    setState(() {});
                  });
                },
                headerDateFormat: "MMMM",
                blackoutDatesTextStyle: TextStyle(
                  color: Colors.red,
                ),
                appointmentTextStyle: TextStyle(
                  color: Colors.red,
                ),
                monthViewSettings: const MonthViewSettings(
                  numberOfWeeksInView: 6,
                  showAgenda: true,
                ),
                controller: calendarController,
                onSelectionChanged: (details) {
                },
              ),
            ),
          ),
          Positioned(
              top: 67,
              right: 10,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                      "assets/images/svg/calendar_schedule.svg"),
                ),
                onTap: () => AppRouter.push(
                  context,
                  const FullCalendarScreen(),
                  rootNavigator: true,
                ).then((value) {
                  if (value is DateTime) {
                    calendarController.displayDate = value;
                    calendarController.selectedDate = value;
                    calendarController.view = CalendarView.day;
                    SchedulerBinding.instance!.addPostFrameCallback((duration) {
                      setState(() {});
                    });
                  }
                }),
              )),
        ],
      ),
    );
  }
}

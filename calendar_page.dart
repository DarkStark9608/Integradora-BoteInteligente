import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
   return Column(children: <Widget>[
    Container(
      child: Text ('Horario de recoleccion de basura', style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25)),),
    
    SfCalendar(      
    view: CalendarView.week,
    
    backgroundColor: Color.fromRGBO(76, 175, 80 ,50),
    dataSource: MeetingDataSource(_getDataSource()),
    cellEndPadding: 5,
      monthViewSettings: MonthViewSettings(
            appointmentDisplayMode:
                MonthAppointmentDisplayMode.appointment),
                )
   ]);
}}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime1 =DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime1 = startTime1.add(const Duration(hours: 1));
  meetings.add(Meeting(
      'Recoleccion Basura', DateTime(2021, 08, 9, 6, 50, 0), DateTime(2021, 08, 9, 6, 10, 0), const Color(0xFFFF0000), false));
  meetings.add(Meeting(
      'Recoleccion Basura', DateTime(2021, 08, 11, 9, 50, 0), DateTime(2021, 08, 11, 9, 10, 0), const Color(0xFFFF0000), false));
  meetings.add(Meeting(
      'Recoleccion Basura', DateTime(2021, 08, 13, 18, 50, 0), DateTime(2021, 08, 13, 18, 10, 0), const Color(0xFFFF0000), false));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

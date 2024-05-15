import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';

  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedCalendarDate;
  late DateTime _initialCalendarDate;
  late DateTime _lastCalendarDate;
  late DateTime? selectedCalendarDate;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _focusedCalendarDate = DateTime.now();
    _initialCalendarDate = DateTime.now().subtract(const Duration(days: 365));
    _lastCalendarDate = DateTime.now().add(const Duration(days: 365));
    _calendarFormat = CalendarFormat.month;
    selectedCalendarDate = _focusedCalendarDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedCalendarDate,
                firstDay: _initialCalendarDate,
                lastDay: _lastCalendarDate,
                selectedDayPredicate: (currentSelectedDate) {
                  return (selectedCalendarDate != null &&
                      isSameDay(selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
              ),
            ),
            // Display events for the selected date
            // Add your event list here
          ],
        ),
      ),
    );
  }
}

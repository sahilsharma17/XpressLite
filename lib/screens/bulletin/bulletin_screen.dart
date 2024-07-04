import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'XPRESS BULLETIN',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body:
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Selected Date - ' + today.toString().split(' ')[0]),
                TableCalendar(
                  locale: "en_US",
                  rowHeight: 40,
                  headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: today,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  onDaySelected: _onDaySelected,

                )
              ],
            ),
          )),
    );
  }


}

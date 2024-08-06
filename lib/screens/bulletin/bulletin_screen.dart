import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresslite/Widget/pdfviewer_pg.dart';
import 'package:xpresslite/helper/app_utilities/size_reziser.dart';
import 'package:xpresslite/model/BulletinPdfModel.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import 'cubit/bulletin_cubit.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  DateTime today = DateTime.now();
  late BulletinCubit _cubit;
  List<BulletinPdfModel> bulletinPdfs = [];
  int selectedMonth = DateTime.now().month;
  DateTime? selectedDate;
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<dynamic>> bulletinsDay = {};
  Map<DateTime, List<String>> bd = {};

  @override
  void initState() {
    _cubit = BlocProvider.of<BulletinCubit>(context);
    _fetchBulletinsForMonth(selectedMonth);
    super.initState();
  }

  void _fetchBulletinsForMonth(int month) {
    final monthString = month.toString().padLeft(2, '0');
    _cubit.getBulletins(monthString, '');

    // Clear bulletinsDay for new month
    setState(() {
      bulletinsDay = {};
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      selectedDate = day;
    });
  }

  void _onMonthChanged(DateTime newMonth) {
    setState(() {
      selectedDate = null;
      selectedMonth = newMonth.month;
      focusedDay = newMonth;
      _fetchBulletinsForMonth(selectedMonth);
    });
  }

  void _updateEvents(List<BulletinPdfModel> bulletins) {
    setState(() {
      bulletinsDay = {}; // Clear the current events map

      // Iterate through each bulletin and add it to the bulletinsDay map
      for (var bulletin in bulletins) {
        // Ensure the insertDate is not null before parsing
        if (bulletin.insertDate != null) {
          DateTime bulletinDate = DateTime.parse(bulletin.insertDate!);

          // Check if the date already exists in bulletinsDay map, if not, initialize it
          if (bulletinsDay[bulletinDate] == null) {
            bulletinsDay[bulletinDate] = [];
          }

          // Add the bulletin to the bulletins list of the corresponding date
          bulletinsDay[bulletinDate]?.add(bulletin);
        }
      }
    });
  }

  void _addEvents(List<BulletinPdfModel> bulletins) {
    setState(() {
      // Iterate through each bulletin and add it to the bd map
      for (var bulletin in bulletins) {
        // Ensure the insertDate is not null before parsing
        if (bulletin.insertDate != null) {
          DateTime bulletinDate = DateTime.parse(bulletin.insertDate!).toUtc();
          DateTime dateWithoutTime = DateTime.utc(
              bulletinDate.year, bulletinDate.month, bulletinDate.day);

          // Check if the date already exists in bd map, if not, initialize it
          if (!bd.containsKey(dateWithoutTime)) {
            bd[dateWithoutTime] = [];
          }

          // Check if the event is already added
          bool isAlreadyAdded = bd[dateWithoutTime]!
              .contains(bulletin.title ?? 'Untitled Bulletin');

          // Add the bulletin title to the events list of the corresponding date if it's not already added
          if (!isAlreadyAdded) {
            bd[dateWithoutTime]!.add(bulletin.title ?? 'Untitled Bulletin');
          }
        }
      }
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
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              BlocConsumer<BulletinCubit, BulletinState>(
                builder: (context, state) {
                  if (state is BulletinLoaded) {
                    bulletinPdfs = state.bulletinModel;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _updateEvents(bulletinPdfs);
                      _addEvents(bulletinPdfs);
                    });
                    return Column(
                      children: [calender(), _buildBulletinList()],
                    );
                  } else if (state is BulletinLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BulletinError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return Container();
                },
                listener: (context, state) {
                  if (state is BulletinError) {
                    MethodUtils.toast(state.error);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletinList() {
    if (bulletinPdfs.isEmpty) {
      return Center(child: Text('No bulletins for this month.'));
    }

    List<BulletinPdfModel> bulletinsToShow = [];
    if (selectedDate != null) {
      bulletinsToShow = bulletinPdfs.where((bulletin) {
        DateTime bulletinDate = DateTime.parse(bulletin.insertDate!);
        return isSameDay(bulletinDate, selectedDate!);
      }).toList();
    } else {
      bulletinsToShow = bulletinPdfs;
    }

    if (bulletinsToShow.isEmpty) {
      return Center(child: Text('No bulletins for this date.'));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      child: ListView.builder(
        itemCount: bulletinsToShow.length,
        itemBuilder: (context, index) {
          final bulletin = bulletinsToShow[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(
                            pdfUrl: bulletin.pdfFileName.toString())));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MethodUtils.getFormattedCustomDate(
                                bulletin.insertDate.toString(),
                                'yyyy-MM-ddTHH:mm:ss',
                                'dd/MM/yyyy'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            bulletin.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset('assets/pdf.png', width: 40, height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget calender() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        // height: SizeConfig.screenHeight * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: TableCalendar(
          locale: "en_US",
          rowHeight: 60,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.utc(2024, 3, 1),
          lastDay: DateTime.utc(2024, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(day, today),
          onDaySelected: _onDaySelected,
          onPageChanged: _onMonthChanged,
          calendarStyle: CalendarStyle(
            defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
            weekendTextStyle: TextStyle(fontWeight: FontWeight.bold),
            todayDecoration: BoxDecoration(
                color: Colors.orange.shade200, shape: BoxShape.circle),
            selectedDecoration:
                BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          ),
          eventLoader: (day) {
            return bd[day] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('assets/pdf.png'))),
                  width: 20,
                  height: 20,
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresslite/constants/strings.dart';
import 'package:xpresslite/model/reportModel.dart';
import 'package:xpresslite/screens/reports/cubit/reports_cubit.dart';

import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late ReportsCubit _cubit;

  List<ReportModel> reports = [];

  int _selectedIndex = 0;
  final List<String> _options = [bulletins, chairmanMsg, directorMsg];
  int _selectedRadioValue = 1;
  String? _selectedMonth;
  String? myMonth;
  TextEditingController? _selectedDate = TextEditingController();
  bool calenderVisible = false;

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedDate?.text = today.toString().split(" ")[0];
      // print(today.toString().substring(6,8));
      calenderVisible = false;
      if (_selectedIndex == 1) {
        _cubit.getCeoReports('', today.toString().split(" ")[0]);
      } else {
        _cubit.getOtherReports('', today.toString().split(" ")[0]);
      }
    });
  }

  late Map<String, double> dataMap;

  @override
  void initState() {
    _cubit = BlocProvider.of<ReportsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: reportTypeFilter(),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            calenderVisible = false;
                            _selectedRadioValue = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text('Month Wise'),
                      ),
                      Radio(
                        value: 2,
                        groupValue: _selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedRadioValue = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text('Date Wise'),
                      ),
                    ],
                  ),
                  if (_selectedRadioValue == 1)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            hint: const Text('Select Month'),
                            elevation: 16,
                            isExpanded: true,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedMonth = newValue;

                                final monthIndex = _months.indexWhere(
                                        (month) => month == newValue) +
                                    1;
                                if (_selectedIndex == 1) {
                                  _cubit.getCeoReports(
                                      monthIndex.toString(), '');
                                } else {
                                  _cubit.getOtherReports(
                                      monthIndex.toString(), '');
                                }
                              });
                            },
                            value: _selectedMonth,
                            items: _months.map((month) {
                              return DropdownMenuItem<String>(
                                value: month,
                                child: Text(month),
                              );
                            }).toList()),
                      ),
                    ),
                  if (_selectedRadioValue == 2)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                        controller: _selectedDate,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 12),
                          border: InputBorder.none,
                          hintText: 'Select a Date',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                calenderVisible = !calenderVisible;
                              });
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Visibility(
                    visible: calenderVisible,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                child: TableCalendar(
                                  locale: "en_US",
                                  rowHeight: 40,
                                  headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true),
                                  availableGestures: AvailableGestures.all,
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: today,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(day, today),
                                  onDaySelected: _onDaySelected,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(color: Colors.grey.shade300, child: bloc()),
            )
          ],
        ),
      ),
    );
  }

  bloc() {
    return BlocConsumer<ReportsCubit, ReportsState>(
        builder: (BuildContext context, state) {
      if (state is ReportsLoaded) {
        reports = state.reportModel ?? [];
        if (reports.isNotEmpty) {
          return reportsWidget();
        } else {
          return Center(
            child: Image.asset(
              'assets/report.gif',
              height: 200,
            ),
          );
        }
      } else if (state is ReportsInitial) {
        return Center(
          child: Image.asset(
            'assets/report.gif',
            height: 200,
          ),
        );
      } else if (state is ReportsLoading) {
        return Stack(
          children: [AppLoaderProgress()],
        );
      } else if (state is ReportsError) {
        return reportsWidget();
      }
      return AccessDeniedScreen(
        onPressed: () {},
      );
    }, listener: (BuildContext context, state) {
      if (state is ReportsError) {
        if (state.error.isNotEmpty) {
          MethodUtils.toast(state.error);
        }
      } else if (state is ReportsLoaded) {}
    });
  }

  reportsWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  reports[index].title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: PieChart(
                    dataMap: dataMap = {
                      "Viewed": reports[index].notViewed?.toDouble() ?? 0,
                      "Not Viewed": reports[index].viewed?.toDouble() ?? 0,
                    },
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 40,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: <Color>[Colors.green, Colors.red],
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 60,
                    legendOptions: LegendOptions(
                      showLegendsInRow: true,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      // legendShape: _BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  reportTypeFilter() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "REPORTS",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _options.map((label) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = _options.indexOf(label);
                      _cubit.refresh();
                      _selectedDate?.text = '';
                      // _selectedMonth = 'abc';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedIndex == _options.indexOf(label)
                              ? Colors.orange
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: _selectedIndex == _options.indexOf(label)
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

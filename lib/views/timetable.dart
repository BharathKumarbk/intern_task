import 'package:flutter/material.dart';
import 'package:interview_task/components/constants.dart';
import 'package:interview_task/controllers/api_service.dart';
import 'package:interview_task/models/week_model.dart';
import 'package:interview_task/views/timetable_view.dart';
import 'package:interview_task/views/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeakModel weak;
  ApiService apiService;
  int selected;
  DateTime selectedDate;
  bool isloading = false;
  bool isinit = false;

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  List<int> getDate(DateTime date) {
    var now = date;
    var totalDays = daysInMonth(now);
    var listOfDates = new List<int>.generate(totalDays, (i) => i + 1);
    return listOfDates;
  }

  initializeDate() async {
    selected = int.parse(DateFormat.d().format(selectedDate));
    setState(() {});
    await apiService
        .getApiData(DateFormat('dd/MM/yyyy').format(selectedDate),
            DateFormat.E().format(selectedDate))
        .then((value) {
      print(DateFormat.E().format(selectedDate));
      setState(() {
        weak = apiService.weakModel;
        isinit = true;
      });
    });
  }

  @override
  void initState() {
    selectedDate = DateTime(2020, 12, 03);
    apiService = ApiService();
    initializeDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiService>(context);
    return Scaffold(
      body: isinit
          ? SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.indigo,
                    child: Row(
                      children: [
                        OutlinedButton.icon(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                  BorderSide(color: kWhite))),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: kWhite,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  child: Container(
                                child: CalendarDatePicker(
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                  onDateChanged: (val) async {
                                    setState(() {
                                      selectedDate = val;
                                      selected = int.parse(
                                          DateFormat.d().format(selectedDate));
                                      isloading = true;
                                    });
                                    Navigator.pop(context);
                                    await provider
                                        .getApiData(
                                            DateFormat('dd/MM/yyyy')
                                                .format(selectedDate),
                                            DateFormat.E().format(selectedDate))
                                        .then((value) {
                                      setState(() {
                                        weak = provider.weakModel;
                                        isloading = false;
                                      });
                                    });
                                  },
                                ),
                              )),
                            );
                          },
                          label: Text(
                            "${DateFormat('d / MMM / yyyy').format(selectedDate)}",
                            style: TextStyle(
                              color: kWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.indigo,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            getDate(selectedDate ?? DateTime.now()).map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat('EEE').format(DateTime(
                                        int.parse(DateFormat.y()
                                            .format(selectedDate)),
                                        int.parse(DateFormat.M()
                                            .format(selectedDate)),
                                        e)),
                                    style: TextStyle(color: kWhite),
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                selected == e
                                                    ? kWhite
                                                    : Colors.transparent)),
                                    onPressed: () async {
                                      setState(() {
                                        selected = e;
                                        selectedDate = DateTime(
                                            int.parse(DateFormat.y()
                                                .format(selectedDate)),
                                            int.parse(DateFormat.M()
                                                .format(selectedDate)),
                                            e);
                                        isloading = true;
                                      });
                                      await provider
                                          .getApiData(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(selectedDate),
                                              DateFormat.E()
                                                  .format(selectedDate))
                                          .then((value) {
                                        setState(() {
                                          isloading = false;
                                          weak = provider.weakModel;
                                        });
                                      });
                                    },
                                    child: Text(
                                      "$e",
                                      style: TextStyle(
                                          color:
                                              selected == e ? kBlack : kWhite),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                      child: isloading
                          ? loadingWidget()
                          : weak.lec.isEmpty
                              ? Center(
                                  child: Text(
                                    "No class Enjoy !!!",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                )
                              : TimeTableView(
                                  weak: weak,
                                ))
                ],
              ),
            )
          : loadingWidget(),
    );
  }
}

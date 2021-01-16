import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/buttom_sheet.dart';
import 'widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pickedTime = '0';
  DateTime dateTime;
  Timer timer;
  int _daysUntil = 0;
  int _hoursUntil = 0;
  int _minUntil = 0;
  int _secUntil = 0;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        pickedTime = timeLeft(dateTime);
        print(pickedTime);
      });
      if (_secUntil <= 0) {
        timer.cancel();
      }
    });
  }

  Widget datetimePicker() {
    return CupertinoDatePicker(
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        setState(() {
          dateTime = newdate;
          pickedTime = newdate.day.toString() +
              '/' +
              newdate.month.toString() +
              '/' +
              newdate.year.toString() +
              ' ' +
              newdate.hour.toString() +
              ' hrs ' +
              newdate.minute.toString() +
              ' mins' +
              newdate.second.toString() +
              ' sec';
        });
      },
      use24hFormat: true,
      maximumDate: new DateTime(2050, 12, 30),
      minimumDate: DateTime.now(),
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          'Pick time first',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  String timeLeft(DateTime due) {
    String retVal;

    Duration _timeUntilDue = due.difference(DateTime.now());

    setState(() {
      _daysUntil = _timeUntilDue.inDays;
      _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
      _minUntil =
          _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
      _secUntil = _timeUntilDue.inSeconds -
          (_daysUntil * 24 * 60 * 60) -
          (_hoursUntil * 60 * 60) -
          (_minUntil * 60);
    });

    if (_daysUntil > 0) {
      retVal = _daysUntil.toString() +
          " days\n" +
          _hoursUntil.toString() +
          " hours" +
          _minUntil.toString() +
          " mins" +
          _secUntil.toString() +
          " seconds";
    } else if (_hoursUntil > 0) {
      retVal = _hoursUntil.toString() +
          " hours\n" +
          _minUntil.toString() +
          " mins\n" +
          _secUntil.toString() +
          ' seconds';
    } else if (_minUntil > 0) {
      retVal =
          _minUntil.toString() + " mins\n" + _secUntil.toString() + " seconds";
    } else if (_secUntil > 0) {
      retVal = _secUntil.toString() + " seconds";
    } else if (_secUntil == 0) {
      retVal = "Count Down Completed! ";
    } else {
      retVal = "error";
    }

    return retVal;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Down'),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 15),
            icon: Text(
              'Stop',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              timer.cancel();
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _secUntil <= 0
                  ? Text(
                      'Pick time to start',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    )
                  : Column(
                      children: [
                        Text(
                          _daysUntil.toString() + ' Days',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _hoursUntil.toString() + 'h ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 30),
                            ),
                            Text(
                              _minUntil.toString() + 'm ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 30),
                            ),
                            Text(
                              _secUntil.toString() + 's',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
              Column(
                children: [
                  button(
                    "Start timer",
                    color: Colors.blueAccent,
                    onPressed: pickedTime == '0'
                        ? () {
                            _showToast(context);
                          }
                        : () {
                            startTimer();
                          },
                  ),
                  button(
                    "Pick time",
                    color: Colors.green,
                    onPressed: () {
                      bottomSheet(
                        context,
                        datetimePicker(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

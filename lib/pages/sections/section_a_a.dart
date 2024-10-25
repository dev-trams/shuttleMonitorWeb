import 'dart:async';

import 'package:flutter/material.dart';

DateTime dateTime = DateTime.now();

class SectionA_A extends StatefulWidget {
  const SectionA_A({super.key});

  @override
  _SectionA_AState createState() => _SectionA_AState();
}

class _SectionA_AState extends State<SectionA_A> {
  String _timeString = "";

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final String formattedTime = _formatDateTime(DateTime.now());
    setState(() {
      _timeString = formattedTime;
    });
    Timer(
      const Duration(seconds: 1) -
          Duration(milliseconds: DateTime.now().millisecond),
      _updateTime,
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final day = DateTime.now().day;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            '경복대학교 셔틀버스 관제시스템',
            style: defaultStyle(size: 20),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  '$year-$month-$day',
                  style: defaultStyle(),
                ),
              ),
              Center(
                child: Text(
                  _timeString,
                  style: defaultStyle(),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              'weather',
              style: defaultStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle defaultStyle({double? size}) =>
    TextStyle(color: Colors.white, fontSize: size ?? 30);

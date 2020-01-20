// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


// Design - Albert Salomon
// Code - Piotr Kamiński ( Forgive me guys if I made some stupid solution or code, it's my first time with flutter , I haven't seen and heard about this before :)

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:digital_clock/dot.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  int _defaultColor = 0xFFFFFFFF;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  int getColor() {
    int dotsColor = 0xff007AFF;
    if (_dateTime.hour >= 3 && _dateTime.hour < 6) {
      dotsColor = 0xff007AFF;
    } else if (_dateTime.hour >= 6 && _dateTime.hour < 9) {
      dotsColor = 0xffFFAB00;
    } else if (_dateTime.hour >= 9 && _dateTime.hour < 12) {
      dotsColor = 0xffFF6400;
    } else if (_dateTime.hour >= 12 && _dateTime.hour < 15) {
      dotsColor = 0xffD50000; //red
    } else if (_dateTime.hour >= 15 && _dateTime.hour < 18) {
      dotsColor = 0xff7109AA;
    } else if (_dateTime.hour >= 18 && _dateTime.hour < 21) {
      dotsColor = 0xff00A21C;
    } else if (_dateTime.hour >= 21 || _dateTime.hour < 3) {
      dotsColor = 0xff0026CA;
    }

    return dotsColor;
  }

  List<Widget> getHoursDots( int from ) {
    List<Widget> childs = [];

    double diagonal = 4;
    int actualHour = _dateTime.hour % 12;

    if ( actualHour == 0 ){
      actualHour = 12;
    }

      for (var i = from + 5; i >= from; i--) {
        diagonal = actualHour >= i ? 20 : 4;
        childs.add(Dot(
          dotColor: _defaultColor,
          diagonal: diagonal,
          line: false,
        ));
      }

    return childs;
  }

  List<Widget> getMinutesDots( int from ) {
    List<Widget> childs = [];

    double diagonal = 4;
    bool tenLine = false;

      for (var i = from; i <= from + 9; i++) {
        diagonal = _dateTime.minute >= i ? 20 : 4;
        tenLine = _dateTime.minute >= from + 9 ? true : false;

        childs.add(Dot(
          dotColor: getColor(),
          diagonal: diagonal,
          line: tenLine,
        ));

        if (tenLine) {
          break;
        }
      }


    return childs;
  }

  List<Widget> getHours() {
    List<Widget> hoursDots = [];

    for (var i = 1; i <= 7; i += 6) {
      hoursDots.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getHoursDots(i),
      ));
    }
    return hoursDots;
  }

  List<Widget> getMinutes() {
    List<Widget> secondsDots = [];

    for (var i = 51; i >= 1; i -= 10) {
      secondsDots.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getMinutesDots(i),
      ));
    }
    return secondsDots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 22, 12, 22),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getHours(),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getMinutes(),
            ),
//
          ],
        ));
  }
}

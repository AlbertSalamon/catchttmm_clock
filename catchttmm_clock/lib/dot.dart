import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final int dotColor;
  final double diagonal;
  final bool line;

  Dot(
      {@required this.dotColor,
      @required this.diagonal,
      @required this.line});

  @override
  Widget build(BuildContext context) {
    if (line) {
      return Container(
        height: (MediaQuery.of(context).size.height - 72) / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedContainer(
              width: (MediaQuery.of(context).size.width - 34) * 0.74,
              height: diagonal,
              decoration: BoxDecoration(
                color: Color(dotColor),
                borderRadius: BorderRadius.circular(50),
              ),
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: (MediaQuery.of(context).size.width - 68) / 12,
        height: (MediaQuery.of(context).size.height - 72) / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: diagonal,
              height: diagonal,
              decoration: BoxDecoration(
                color: Color(dotColor),
                borderRadius: BorderRadius.circular(50),
              ),
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            ),
          ],
        ),
      );
    }
  }
}

import 'package:alarm/presentation/theme/light.dart';
import 'package:flutter/material.dart';

Widget alarmItem(Size size, {required String title1, required String title2}) {
  return Column(
    children: [
      SizedBox(
        height: size.height * 0.015,
      ),
      Container(
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: borderColor, width: size.width * 0.012))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: size.width * 0.048),
            ),
            Text(
              title2,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: size.width * 0.048),
            ),
          ],
        ),
      ),
    ],
  );
}

void appSnack(BuildContext context, String content) {
  var snackBar =
      SnackBar(backgroundColor: Colors.black, content: Text(content));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

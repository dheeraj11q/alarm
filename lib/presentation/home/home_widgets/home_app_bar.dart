import 'package:alarm/presentation/add_alarm/add_alarm.dart';
import 'package:alarm/presentation/theme/light.dart';
import 'package:flutter/material.dart';

Widget homeAppBar(Size size, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(size.width * 0.04),
    color: appBarColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Edit",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: size.width * 0.045),
        ),
        Text(
          "Alarm",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: size.width * 0.045),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddAlarm()));
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}

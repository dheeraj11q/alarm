import 'package:alarm/bussiness_logic/alarm_cubit/alarm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Widget tapTime(Size size, {VoidCallback? onTap}) {
  return BlocBuilder<AlarmCubit, AlarmState>(
    builder: (context, state) {
      AlarmCubit _alarmCubit = BlocProvider.of<AlarmCubit>(context);
      return Column(children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            DateFormat("h:mm").format(state.datetime),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _alarmCubit.updateAMPM(true);
              },
              child: Text(
                "AM",
                style: TextStyle(
                    color: state.isAm ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.05),
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Container(
              color: Colors.grey,
              width: size.width * 0.008,
              height: size.height * 0.04,
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            GestureDetector(
              onTap: () {
                _alarmCubit.updateAMPM(false);
              },
              child: Text(
                "PM",
                style: TextStyle(
                    color: state.isAm ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.05),
              ),
            ),
          ],
        )
      ]);
    },
  );
}

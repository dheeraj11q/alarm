import 'package:alarm/bussiness_logic/alarm_cubit/alarm_cubit.dart';
import 'package:alarm/data/alarm_model.dart';
import 'package:alarm/presentation/add_alarm/add_alarm_widgets/alarm_items.dart';
import 'package:alarm/presentation/theme/light.dart';
import 'package:alarm/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Widget alarmListItem(
  BuildContext context,
  Size size, {
  AlarmModel? alarmModel,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 2),
    padding: EdgeInsets.all(size.width * 0.05),
    color: alarmModel?.isOn == "true" ? Colors.white : borderColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: DateFormat("hh:mm").format(alarmModel!.dateTime),
              style: TextStyle(
                  color: alarmModel.isOn == "true"
                      ? Colors.black
                      : Colors.grey.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.1),
            ),
            TextSpan(
              text: " ${DateFormat("a").format(alarmModel.dateTime)}",
              style: TextStyle(
                  color: alarmModel.isOn == "true"
                      ? Colors.black
                      : Colors.grey.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.05),
            )
          ]),
        ),
        Switch(
          onChanged: (bool active) async {
            AlarmModel alarmModelRes =
                await BlocProvider.of<AlarmCubit>(context)
                    .alarmUpdate(alarmModel: alarmModel, active: active);

            if (active) {
              AlarmService.set(alarmModel);
              appSnack(context, "Alarm on");
            } else {
              AlarmService.cancel(alarmModelRes);
              appSnack(context, "Alarm off");
            }
          },
          value: alarmModel.isOn == "true",
          activeColor: Colors.white,
          activeTrackColor: primaryColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.withOpacity(0.7),
        )
      ],
    ),
  );
}

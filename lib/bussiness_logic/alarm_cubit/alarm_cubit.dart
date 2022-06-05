import 'package:alarm/data/alarm_model.dart';
import 'package:alarm/presentation/add_alarm/add_alarm_widgets/alarm_items.dart';
import 'package:alarm/data/db_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'alarm_state.dart';

TimeOfDay timeOfDay = TimeOfDay.now();
final dbhelper = Databasehelper.instance;

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit()
      : super(AlarmState(
            datetime: DateTime.now(),
            isAm: true,
            alarmNameTextCtrl: TextEditingController(),
            alarmList: const {}));

// select time and update
  void timePick(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: timeOfDay,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data:
                MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked != null && picked != timeOfDay) {
      timeOfDay = picked;

      final now = DateTime.now();
      final dateTime = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

      emit(state.copyWith(
          isAm: timeOfDay.period == DayPeriod.am, datetime: dateTime));
    }
  }

  void updateAMPM(bool ampm) {
    emit(state.copyWith(isAm: ampm));
  }

  // [get alarm list form local data base]

  void getAlarmList() async {
    var alarmListData = await dbhelper.queryall();

    Map<int, AlarmModel> alarmList = {};

    for (int i = 0; i < alarmListData.length; i++) {
      AlarmModel inModel = AlarmModel(
          id: alarmListData[i]["id"],
          name: alarmListData[i]["name"],
          dateTime: DateTime.parse(alarmListData[i]["datetime"]),
          isOn: alarmListData[i]["isOn"]);

      alarmList[alarmListData[i]["id"]] = inModel;
    }

    emit(state.copyWith(alarmList: alarmList));
  }

  Future<AlarmModel> addAlarm(
    BuildContext context,
  ) async {
    AlarmModel alarmModel = AlarmModel(
        name: state.alarmNameTextCtrl!.text,
        dateTime: state.datetime,
        isOn: "true");

    int? isAvailableId = await matchTimeWithOldAlarms(
        alarmList: state.alarmList!, currentAlarm: alarmModel);

    if (isAvailableId == null) {
      int id = await dbhelper.insert(alarmModel);
      alarmModel.id = id;
      appSnack(context, "Alarm Saved");
    } else {
      alarmModel.id = isAvailableId;

      alarmUpdate(alarmModel: alarmModel);
    }

    getAlarmList();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });

    return alarmModel;
  }

  Future<AlarmModel> alarmUpdate(
      {required AlarmModel alarmModel, bool active = true}) async {
    Map<int, AlarmModel> alarmMap = state.alarmList!;
    alarmMap[alarmModel.id]!.isOn = active ? "true" : "false";
    emit(state.copyWith(alarmList: {}));
    emit(state.copyWith(alarmList: alarmMap));
    alarmModel.isOn = active ? "true" : "false";
    dbhelper.update(alarmModel);

    return alarmModel;
  }
}

Future<int?> matchTimeWithOldAlarms(
    {required Map<int, AlarmModel> alarmList,
    required AlarmModel currentAlarm}) async {
  int? returnData;
  for (AlarmModel alarm in alarmList.values) {
    if (DateTime(alarm.dateTime.year, alarm.dateTime.month, alarm.dateTime.day,
            alarm.dateTime.hour, alarm.dateTime.minute, 0) ==
        DateTime(
            currentAlarm.dateTime.year,
            currentAlarm.dateTime.month,
            currentAlarm.dateTime.day,
            currentAlarm.dateTime.hour,
            currentAlarm.dateTime.minute,
            0)) {
      returnData = alarm.id;

      break;
    }
  }

  return returnData;
}

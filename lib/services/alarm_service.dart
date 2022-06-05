import 'dart:isolate';
import 'dart:ui';
import 'package:alarm/data/alarm_model.dart';
import 'package:alarm/notification_api.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

const String portName = "ConnectIsolate";

class AlarmService {
  // set alarm and schedule notification
  static void set(AlarmModel alarmModel) {
    // notificatiion

    LocalNotificationApi.showScheduleNotification(
        body: alarmModel.name,
        scheduledDate:
            DateTime.now().add(alarmTimeCalculate(alarmModel.dateTime)));

    // alarm
    AndroidAlarmManager.oneShot(
        Duration(
            seconds: (alarmTimeCalculate(alarmModel.dateTime).inSeconds - 60)),
        alarmModel.id!,
        playRingtone);
  }

  static void cancel(AlarmModel alarmModel) {
    AndroidAlarmManager.cancel(alarmModel.id!);
  }

// ringtone play and stop

  static Future<void> playRingtone() async {
    ReceivePort receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);
    receivePort.listen((v) {
      FlutterRingtonePlayer.stop();
    });

    FlutterRingtonePlayer.playAlarm(looping: true);
  }

  static Future<void> stopRingtone() async {
    SendPort? sendPort = IsolateNameServer.lookupPortByName(portName);
    sendPort?.send("stopRingtone");
  }
}

// calculate alarm time in seconds

Duration alarmTimeCalculate(DateTime datetime) {
  DateTime dateTimeNow = DateTime.now();

  int nowTimeSeconds = Duration(
          hours: dateTimeNow.hour,
          minutes: dateTimeNow.minute,
          seconds: dateTimeNow.second)
      .inSeconds;
  int myTimeSeconds = Duration(
          hours: datetime.hour,
          minutes: datetime.minute,
          seconds: datetime.second)
      .inSeconds;

  int daySecond = 84600;

  if (nowTimeSeconds > myTimeSeconds) {
    return Duration(seconds: daySecond - (nowTimeSeconds - myTimeSeconds));
  } else if (nowTimeSeconds < myTimeSeconds) {
    return Duration(seconds: (myTimeSeconds - nowTimeSeconds));
  } else if (nowTimeSeconds == myTimeSeconds) {
    return Duration(seconds: (myTimeSeconds - nowTimeSeconds));
  } else {
    return const Duration(seconds: 0);
  }
}

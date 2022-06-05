import 'package:alarm/bussiness_logic/alarm_cubit/alarm_cubit.dart';
import 'package:alarm/notification_api.dart';
import 'package:alarm/presentation/home/home.dart';
import 'package:alarm/presentation/theme/light.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  LocalNotificationApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AlarmCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alarm',
        theme: themeLight,
        home: const Home(),
      ),
    );
  }
}

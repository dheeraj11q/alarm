import 'package:alarm/bussiness_logic/alarm_cubit/alarm_cubit.dart';
import 'package:alarm/data/alarm_model.dart';
import 'package:alarm/presentation/add_alarm/add_alarm_widgets/alarm_items.dart';
import 'package:alarm/presentation/add_alarm/add_alarm_widgets/tap_time.dart';
import 'package:alarm/presentation/theme/light.dart';
import 'package:alarm/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({Key? key}) : super(key: key);

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AlarmCubit alarmCubit = BlocProvider.of<AlarmCubit>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff565556),
            )),
        elevation: 0,
        title: Text(
          "Set New Alarm",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: size.width * 0.045),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              tapTime(size, onTap: () {
                alarmCubit.timePick(context);
              }),

              // add alarm name

              Container(
                margin: EdgeInsets.all(size.width * 0.04),
                child: TextField(
                  controller: alarmCubit.state.alarmNameTextCtrl,
                  decoration: const InputDecoration(
                      labelText: "Alarm Name",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),

              // alarm other fields

              alarmItem(size, title1: "Sound", title2: "Default"),
              alarmItem(size, title1: "Snooze", title2: "Never"),
              alarmItem(size, title1: "Repeat", title2: "Never"),

              SizedBox(
                height: size.height * 0.05,
              ),

              // save alarm

              InkWell(
                onTap: () async {
                  AlarmModel alarmModel = await alarmCubit.addAlarm(context);
                  AlarmService.set(alarmModel);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.3),
                  decoration: BoxDecoration(
                      color: const Color(0xffacb38c),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xffaeb48f), Color(0xffaeb48c)]),
                      borderRadius: BorderRadius.circular(size.width * 0.01)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.05),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

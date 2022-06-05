import 'package:alarm/bussiness_logic/alarm_cubit/alarm_cubit.dart';
import 'package:alarm/presentation/home/home_widgets/alarm_list_item.dart';
import 'package:alarm/presentation/home/home_widgets/home_app_bar.dart';
import 'package:alarm/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AlarmCubit alarmCubit = BlocProvider.of<AlarmCubit>(context);

    alarmCubit.getAlarmList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AlarmService.stopRingtone();
        },
        child: const Icon(Icons.stop),
      ),
      body: SafeArea(
        child: Column(
          children: [
            homeAppBar(size, context),
            BlocBuilder<AlarmCubit, AlarmState>(builder: ((context, state) {
              return Expanded(
                  child: (state.alarmList ?? {}).isEmpty
                      ? Center(
                          child: Text(
                            "Empty",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.05),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.alarmList?.length,
                          itemBuilder: (context, index) {
                            List alarmsData = state.alarmList!.values.toList();
                            return alarmListItem(context, size,
                                alarmModel: alarmsData[index]);
                          },
                        ));
            }))
          ],
        ),
      ),
    );
  }
}

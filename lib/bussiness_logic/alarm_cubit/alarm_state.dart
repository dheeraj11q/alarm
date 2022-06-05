part of 'alarm_cubit.dart';

class AlarmState extends Equatable {
  final DateTime datetime;
  final bool isAm;
  final TextEditingController? alarmNameTextCtrl;
  final Map<int, AlarmModel>? alarmList;
  const AlarmState(
      {required this.datetime,
      required this.isAm,
      this.alarmNameTextCtrl,
      this.alarmList});

  AlarmState copyWith(
      {DateTime? datetime, bool? isAm, Map<int, AlarmModel>? alarmList}) {
    return AlarmState(
        datetime: datetime ?? this.datetime,
        isAm: isAm ?? this.isAm,
        alarmNameTextCtrl: alarmNameTextCtrl,
        alarmList: alarmList ?? this.alarmList);
  }

  @override
  List<Object> get props => [datetime, isAm, alarmNameTextCtrl!, alarmList!];
}

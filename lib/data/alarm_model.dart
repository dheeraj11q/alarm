class AlarmModel {
  int? id;
  String name;
  DateTime dateTime;
  String isOn;

  AlarmModel(
      {this.id,
      required this.name,
      required this.dateTime,
      required this.isOn});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['datetime'] = dateTime;
    data['isOn'] = isOn;
    return data;
  }
}

// class AlarmModel2 {
//   List<Alarms>? alarms;

//   AlarmModel2({this.alarms});

//   AlarmModel2.fromJson(Map<String, dynamic> json) {
//     if (json['alarms'] != null) {
//       alarms = <Alarms>[];
//       json['alarms'].forEach((v) {
//         alarms!.add(new Alarms.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.alarms != null) {
//       data['alarms'] = this.alarms!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Alarms {
//   String? id;
//   String? name;
//   String? datetime;
//   String? isOn;

//   Alarms({this.id, this.name, this.datetime, this.isOn});

//   Alarms.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     datetime = json['datetime'];
//     isOn = json['isOn'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['datetime'] = this.datetime;
//     data['isOn'] = this.isOn;
//     return data;
//   }
// }

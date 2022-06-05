import 'package:alarm/services/alarm_service.dart';
import 'package:flutter/material.dart';

void alarmDialog(BuildContext context, {DateTime? dateTime}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            content: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Wrap(children: [
                Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.width * 0.05)),
                  child: Column(
                    children: [
                      SizedBox(
                          width: size.width * 0.5,
                          height: size.height * 0.3,
                          child: Image.asset("assets/images/alarm.png")),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "09:00",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.1),
                          ),
                          TextSpan(
                            text: " PM",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.05),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          AlarmService.stopRingtone();
                          Navigator.pop(context);
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
                                  colors: [
                                    Color(0xffaeb48f),
                                    Color(0xffaeb48c)
                                  ]),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.01)),
                          child: Text(
                            "STOP",
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ));
      });
}

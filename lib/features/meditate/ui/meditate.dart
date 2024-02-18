import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mygymbuddy/audio/play_notification_audio.dart';

class StartMeditation extends StatefulWidget {
  const StartMeditation({Key? key}) : super(key: key);
  @override
  State<StartMeditation> createState() => _HomePageState();
}

class _HomePageState extends State<StartMeditation> {
  final PlayNotificiationSound playNotificiationSound =
      PlayNotificiationSound();
  AudioPlayer audioPlayer = AudioPlayer();

  Timer? timer;

  List hoursList = [];
  List minutesList = [];
  List secondsList = [];

  String? hoursVal;
  String? minutesVal;
  String? secondsVal;

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  String displayTime = '00:00:00';

  runTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds = seconds - 1;
      }
      if (seconds == 0) {
        if (minutes > 0) {
          minutes = minutes - 1;
          seconds = 60;
        }
      }
      if (minutes == 0) {
        if (hours > 0) {
          hours = hours - 1;
          minutes = 60;
        }
      }

      String result =
          '${hours < 10 ? '0' : ''}$hours : ${minutes < 10 ? '0' : ''}$minutes : ${seconds < 10 ? '0' : ''}$seconds';
      displayTime = result;
      setState(() {});
    });
  }

  stopTimerr() {
    playNotificiationSound.playNotification();

    timer!.cancel();
    setState(() {});
  }

  resetTimerr() {
    stopTimerr();
    hours = 0;
    minutes = 0;
    seconds = 0;
    hoursVal = '0';
    minutesVal = '0';
    secondsVal = '0';
    displayTime = '00:00:00';
    setState(() {});
  }

  @override
  void initState() {
    for (int i = 0; i < 25; i++) {
      hoursList.add(i.toString());
    }

    for (int i = 0; i < 61; i++) {
      minutesList.add(i.toString());
    }

    for (int i = 0; i < 61; i++) {
      secondsList.add(i.toString());
    }

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    stopTimerr();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Text(
            "START MEDITATION",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          // It will display the Flutter timer
          Text(
            displayTime,
            style: TextStyle(
              color: timer == null ? Colors.grey : Colors.blue,
              fontSize: 60,
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Hours',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: .5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          isExpanded: true,
                          hint: Text(
                            'Select',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          value: hoursVal,
                          items: [
                            for (int i = 0; i < hoursList.length; i++)
                              DropdownMenuItem(
                                  value: hoursList[i],
                                  child: Text(hoursList[i].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              hoursVal = val.toString();
                              hours = int.parse(hoursVal!);
                            });
                          }),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Minutes',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: .5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          isExpanded: true,
                          hint: Text(
                            'Select',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          value: minutesVal,
                          items: [
                            for (int i = 0; i < minutesList.length; i++)
                              DropdownMenuItem(
                                  value: minutesList[i],
                                  child: Text(minutesList[i].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              minutesVal = val.toString();
                              minutes = int.parse(minutesVal!);
                            });
                          }),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Seconds',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 70,
                    height: 35,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: .5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          isExpanded: true,
                          hint: Text(
                            'Select',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          value: secondsVal,
                          items: [
                            for (int i = 0; i < secondsList.length; i++)
                              DropdownMenuItem(
                                  value: secondsList[i],
                                  child: Text(secondsList[i].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              secondsVal = val.toString();
                              seconds = int.parse(secondsVal!);
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: (hours == 0 && minutes == 0 && seconds == 0)
                      ? null
                      : stopTimerr,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white60,
                  textColor: Colors.white,
                  color: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                MaterialButton(
                  onPressed: (hours == 0 && minutes == 0 && seconds == 0)
                      ? null
                      : resetTimerr,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white60,
                  color: Colors.green.shade600,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: (hours == 0 && minutes == 0 && seconds == 0)
                  ? null
                  : () {
                      if (timer != null) {
                        stopTimerr();
                      }
                      runTimer();
                    },
              color: Colors.blue.shade600,
              height: 50,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white60,
              textColor: Colors.white,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

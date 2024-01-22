import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen() : super();

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decreaseCounter();
  }

  int totalDuration = 120;
  int intialPosition = 60;
  double remainingTime = 0;
  var format = DateFormat('hh:mm:ss');
  Timer? tmr;
  Duration tme = Duration(seconds: 60);

  void decreaseCounter() {
    tmr = Timer.periodic(const Duration(seconds: 1), (timer) {
      intialPosition = intialPosition - 1;
      tme = tme - Duration(seconds: 1);
      // remainingTime = totalDuration - intialPosition;
      // _controller.restart(
      //     duration: totalDuration, initialPosition: remainingTime);

      debugPrint("Seconds Lapsed : $intialPosition");
      if (intialPosition == 0) {
        tmr!.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    tmr!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1C1C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      value: intialPosition / totalDuration,
                      backgroundColor: Colors.grey,
                    )),
                Positioned.fill(
                    child: Center(
                        child: Text(
                  "${tme.inHours.toString().padLeft(2, "0")}:${tme.inMinutes.toString().padLeft(2, "0")}:${tme.inSeconds.toString().padLeft(2, "0")}",
                  style: TextStyle(color: Colors.white),
                )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

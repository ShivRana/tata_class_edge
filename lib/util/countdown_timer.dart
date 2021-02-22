import 'package:flutter/material.dart';

import 'custom_timer_painter.dart';

class CountDownTimer extends StatefulWidget {
  int duration;

  Function onComplete;

  CountDownTimer(this.duration, this.onComplete);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addListener(() {
      if (controller.status == AnimationStatus.dismissed) {
        print("TimeOver yes");
        widget.onComplete();
      }
    });
    // controller.reverse(widget.duration.toDouble());
    // controller.reverse(from: controller.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          timerString,
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      child: CustomPaint(
                          painter: CustomTimerPainter(
                        animation: controller,
                        backgroundColor: Colors.white,
                        color: Colors.red,
                      )),
                      height: 150,
                      width: 150,
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

// AnimatedBuilder(
// animation: controller,
// builder: (context, child) {
// return FloatingActionButton.extended(
// onPressed: () {
// if (controller.isAnimating)
// controller.stop();
// else {
// controller.reverse(
// from: controller.value == 0.0
// ? 1.0
//     : controller.value);
// }
// },
// icon: Icon(controller.isAnimating
// ? Icons.pause
//     : Icons.play_arrow),
// label: Text(
// controller.isAnimating ? "Pause" : "Play"));
// }),

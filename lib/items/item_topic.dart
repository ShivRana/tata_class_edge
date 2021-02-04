import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tata_classedge/view/quiz_layout.dart';
import 'package:tata_classedge/view/video_layout.dart';

class ItemTopics extends StatelessWidget {
  String topic;

  int index;

  ItemTopics(this.topic, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playVideo(context, topic),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              topic,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  playVideo(context, String topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoLayout(index,topic),
        // builder: (context) => QuizLayout(),
      ),
    );
  }
}

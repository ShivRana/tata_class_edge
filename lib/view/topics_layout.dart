import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tata_classedge/items/item_topic.dart';
import 'package:tata_classedge/model/question_model.dart';

class TopicsLayout extends StatefulWidget {
  @override
  _TopicsLayout createState() => _TopicsLayout();
}

class _TopicsLayout extends State<TopicsLayout> {
  List<String> topics = [
    "Why does country needs constitution",
    "Do you think Corona Virus outbreak can Reshape Global Order?",
    "Could Iran decide for closer cooperation with China?",
    "Does terrorism in the world have any impact on International Oil Prices?",
    "Is international politics a nasty and dangerous business?",
    "Is the EU referendum vote legally binding?",
    "Why does country needs constitution",
    "Do you think Corona Virus outbreak can Reshape Global Order?",
    "Could Iran decide for closer cooperation with China?",
    "Does terrorism in the world have any impact on International Oil Prices?",
    "Is international politics a nasty and dangerous business?",
    "Is the EU referendum vote legally binding?",
    "Why does country needs constitution",
    "Do you think Corona Virus outbreak can Reshape Global Order?",
    "Could Iran decide for closer cooperation with China?",
    "Does terrorism in the world have any impact on International Oil Prices?",
    "Is international politics a nasty and dangerous business?",
    "Is the EU referendum vote legally binding?"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose a topic",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemTopics(topics[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

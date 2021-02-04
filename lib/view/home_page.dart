import 'package:flutter/material.dart';
import 'package:tata_classedge/items/item_topic.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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

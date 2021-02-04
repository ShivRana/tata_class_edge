import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tata_classedge/items/item_topic.dart';
import 'package:tata_classedge/model/question_model.dart';

class QuizLayout extends StatefulWidget {
  @override
  _QuizLayout createState() => _QuizLayout();
}

class _QuizLayout extends State<QuizLayout> {
  @override
  void initState() {
    getQuestionsFromAssets();
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
              "Quiz",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ItemTopics("topics[index]", index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<QuestionModel>> getQuestionsFromAssets() async {
    String data = await rootBundle.loadString('assets/json/question1.json');
    print("JSON " + data);
    List jsonResult = json.decode(data);
    return jsonResult.map((item) => new QuestionModel.fromJson(item)).toList();
  }
}

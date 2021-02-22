import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tata_classedge/model/question_model.dart';
import 'package:tata_classedge/util/countdown_timer.dart';
import 'package:tata_classedge/view/quiz_options.dart';
import 'package:tata_classedge/view/topics_layout.dart';

class QuizLayout extends StatefulWidget {
  @override
  _QuizLayout createState() => _QuizLayout();
}

class _QuizLayout extends State<QuizLayout> with TickerProviderStateMixin {
  Future<List<QuestionModel>> _quizFromAssets;

  @override
  void initState() {
    _quizFromAssets = getQuestionsFromAssets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: FutureBuilder<List<QuestionModel>>(
        future: _quizFromAssets,
        builder: (BuildContext context,
            AsyncSnapshot<List<QuestionModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text("Some Error"),
            );
          } else {
            List<QuestionModel> response = snapshot.data ?? [];
            return Column(children: <Widget>[
              //Most Popular
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 15, right: 15, bottom: 10),
                child: Text(
                  response[0].data.stimulus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CountDownTimer(
                  response[0].data.metadata.duration, _onTimerComplete),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: response[0].data.options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuizOptionWidget(response[0].data.options[index]);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]);
          }
        },
      ),
    );
  }

  Future<List<QuestionModel>> getQuestionsFromAssets() async {
    String data = await rootBundle.loadString('assets/json/question1.json');
    print("JSON " + data);
    List jsonResult = json.decode(data);
    return jsonResult.map((item) => new QuestionModel.fromJson(item)).toList();
  }

  _onTimerComplete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Time Over!"),
          content: new Text("You will be redirected to the topics"),
          actions: [
            RaisedButton(
              onPressed: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TopicsLayout()),
                    (Route<dynamic> route) => false),
              },
              child: Text("Close"),
            )
          ],
        );
      },
    );
  }
}

class ItemQuizQuestions {
  ItemQuizQuestions(QuestionModel response);
}

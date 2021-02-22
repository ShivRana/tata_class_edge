import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tata_classedge/model/question_model.dart';
import 'package:tata_classedge/view/topics_layout.dart';
import 'package:tata_classedge/view/video_layout.dart';

class TopicVerifierLayout extends StatefulWidget {
  Options option;

  TopicVerifierLayout(this.option);

  @override
  _TopicVerifierLayoutState createState() => _TopicVerifierLayoutState();
}

class _TopicVerifierLayoutState extends State<TopicVerifierLayout> {
  bool resultScreen = false;
  bool resultCorrect = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Container(
          height: 150,
          child: Hero(
            tag: widget.option.label,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20),
                ),
                elevation: 4.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 50,
                      child: resultScreen
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  resultCorrect ? Icons.check : Icons.dangerous,
                                  size: 20,
                                  color:
                                      resultCorrect ? Colors.green : Colors.red,
                                ),
                                Text(
                                  resultCorrect ? "Correct" : "Wrong",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: resultCorrect
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            )
                          : Text(
                              widget.option.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  openOptionVerifier(BuildContext context, Options option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicVerifierLayout(option),
        // builder: (context) => QuizLayout(),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(
        Duration(seconds: 3),
        (timer) => {
              if (timer.tick == 2)
                {
                  setState(() {
                    resultCorrect = widget.option.isCorrect == 1;
                    resultScreen = true;
                  })
                }
              else
                {
                  if (timer.tick == 3)
                    {
                      showDismissDialog()
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => TopicsLayout()),
                      //     (Route<dynamic> route) => false),
                    }
                }
            });
  }

  showDismissDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Answer Submitted!"),
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

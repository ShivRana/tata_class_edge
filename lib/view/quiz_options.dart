import 'package:flutter/material.dart';
import 'package:tata_classedge/model/question_model.dart';
import 'package:tata_classedge/view/topic_verifier_layout.dart';

class QuizOptionWidget extends StatelessWidget {
  Options option;

  QuizOptionWidget(this.option);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {openOptionVerifier(context, option)},
      child: Hero(
        tag: option.label,
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
                  child: Text(
                    option.label,
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
}

import 'package:flutter/material.dart';
import 'package:quiz_app/screens/select_quiz_screen.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final noOfQues;

  ResultScreen({@required this.score, @required this.noOfQues});

  @override
  Widget build(BuildContext context) {
    // page
    return Scaffold(
      backgroundColor: Color(0xFF364f6b),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // it can accept multiple widgets
          children: <Widget>[
            Text(
              "Result",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$score/" + noOfQues,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 60,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            customBotton(
              text: 'Restart',
              context: context,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectQuizScreen();
                        },
                      ),
                    );
              }
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/screens/result_screen.dart';

class QuizQuestionsScreen extends StatefulWidget {
  final String amount;
  final int cateogry;
  final String diff;
  final String type;

  const QuizQuestionsScreen(
      {@required this.amount,
      @required this.cateogry,
      @required this.diff,
      @required this.type});

  @override
  _QuizQuestionsScreenState createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  int currentQuestion = 0;
  QuizModel quizModel;

  int totalSeconds = 15;
  int elapsedSeconds = 0;
  Timer timer;
  int score = 0;

  @override
  void initState() {
    getAllQuiz();
    super.initState();
  }

  Future<QuizModel> getAllQuiz() async {
    var response = await http.get(
        'https://opentdb.com/api.php?amount=${widget.amount}&category=${widget.cateogry}&difficulty=${widget.diff}&type=${widget.type}');
    setState(() {
      quizModel = QuizModel.fromJson(jsonDecode(response.body));
      quizModel.results[currentQuestion].incorrectAnswers
          .add(quizModel.results[currentQuestion].correctAnswer);

      quizModel.results[currentQuestion].incorrectAnswers.shuffle();

      initTimer();
    });
    return quizModel;
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        print("Time completed");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  checkAnswer(answer) {
    String correctAnswer = quizModel.results[currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score += 1;
    } else {
      print("Wrong");
    }
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();

    // check if it is last question
    if (currentQuestion == quizModel.results.length - 1) {
      print("Quiz Completed");
      print("Score: $score");

      // navigate to result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            noOfQues: widget.amount,
          ),
        ),
      );
    } else {
      setState(() {
        currentQuestion += 1;
      });

      quizModel.results[currentQuestion].incorrectAnswers
          .add(quizModel.results[currentQuestion].correctAnswer);

      quizModel.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizModel != null) {
      return Scaffold(
        backgroundColor: Color(0xFF364f6b),
        appBar: AppBar(
          backgroundColor: Color(0xFF364f6b),
          title: Text('Quiz'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock,
                            color: Colors.white,
                          ),
                          Text(
                            "$elapsedSeconds s",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        currentQuestion.toString() + ' / ' + widget.amount,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //question

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Text(
                    "Q.  ${quizModel.results[currentQuestion].question}",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // options

                Column(
                  children: quizModel.results[currentQuestion].incorrectAnswers
                      .map((option) {
                    return InkWell(
                      onTap: () {
                        checkAnswer(option);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueGrey, width: 5),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF364f6b),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

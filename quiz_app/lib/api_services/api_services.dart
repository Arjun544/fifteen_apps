import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz_model.dart';

class ApiServices {
  var client = http.Client();
  QuizModel quizModel;

  Future<QuizModel> getQuizData(
      {String amount, int category, String diff, String type}) async {
    try {
      var response = await client.get(
          'https://opentdb.com/api.php?amount=$amount&category=$category&difficulty=$diff&type=$type');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        quizModel = QuizModel.fromJson(jsonMap);
      }
    } catch (e) {
      print(e);
    }
    return quizModel;
  }
}

// Container(
//                           alignment: Alignment.center,
//                           margin: const EdgeInsets.only(right: 10),
//                           decoration: BoxDecoration(
//                               color: Color(0xFFf0f0f0),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 20),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   data.question,
//                                   style: TextStyle(
//                                       fontSize: 22,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     checkAnswer(option);
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: screenWidth * 0.7,
//                                     margin: const EdgeInsets.only(bottom: 10),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       color:
//                                           isCorrect ? Colors.green : Colors.red,
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                           color: Colors.blueGrey, width: 5),
//                                     ),
//                                     child: Text(
//                                       item,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
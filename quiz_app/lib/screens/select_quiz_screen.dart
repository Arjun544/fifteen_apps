import 'package:flutter/material.dart';
import 'package:quiz_app/models/categories.dart';
import 'package:quiz_app/screens/quiz_questions_screen.dart';
import 'package:quiz_app/widgets/build_number_of_ques.dart';
import 'package:quiz_app/widgets/build_snack_bar.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class SelectQuizScreen extends StatefulWidget {
  @override
  _SelectQuizScreenState createState() => _SelectQuizScreenState();
}

class _SelectQuizScreenState extends State<SelectQuizScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String selectedDifficulty = 'easy';
  String selectedType = 'multiple';

  int cateogryId;
  bool isloading = false;

  @override
  void initState() {
    textEditingController.addListener(_handleNumber);
    super.initState();
  }

  void _handleNumber() {
    if (textEditingController.text.isNotEmpty) {
      var num = int.parse(textEditingController.text);
      if (num <= 50) {
        print(num);
      } else {
        buildSnackBar(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF364f6b),
      appBar: AppBar(
        title: Text(
          'Select Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF364f6b),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNumberOfQues(
              controller: textEditingController,
              height: 60,
              width: screenWidth * 0.9,
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<Categories>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                    labelStyle: TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.blueGrey,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  value: categoriesList[0],
                  items: categoriesList.map((Categories user) {
                    return new DropdownMenuItem<Categories>(
                      value: user,
                      child: Text(
                        user.name,
                      ),
                    );
                  }).toList(),
                  onChanged: (Categories value) {
                    setState(() {
                      cateogryId = value.id;
                    });
                    print(cateogryId);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Select Difficulty',
                    labelStyle: TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.blueGrey,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  value: selectedDifficulty,
                  items: <String>[
                    'easy',
                    'medium',
                    'hard',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      selectedDifficulty = value;
                    });
                    print(selectedDifficulty);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Select Type',
                    labelStyle: TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.blueGrey,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  value: selectedType,
                  items: <String>[
                    'multiple',
                    'boolean',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      selectedType = value;
                    });
                    print(selectedType);
                  }),
            ),
            customBotton(
                text: isloading ? 'Preparing...' : 'Start',
                context: context,
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QuizQuestionsScreen(
                          amount: textEditingController.text.isEmpty
                              ? 5.toString()
                              : textEditingController.text,
                          cateogry: cateogryId ?? 0,
                          diff: selectedDifficulty,
                          type: selectedType,
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

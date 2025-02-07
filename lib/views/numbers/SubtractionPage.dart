import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

class SubtractionPage extends StatefulWidget {
  @override
  _SubtractionPageState createState() => _SubtractionPageState();
}

class _SubtractionPageState extends State<SubtractionPage> {
  final Random random = Random();
  int currentIndex = 0;
  int score = 0;

  //  Generate 30 subtraction questions
  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions();
  }

  List<Map<String, dynamic>> generateQuestions() {
    List<Map<String, dynamic>> allQuestions = [];

    while (allQuestions.length < 30) {
      int num1 = random.nextInt(20) + 1; // Generate numbers up to 20
      int num2 = random.nextInt(num1) + 1; // Generate numbers up to num1 (to ensure positive result)
      int correctAnswer = num1 - num2;

      // Ensure choices are distinct and don't include duplicates
      List<int> choices = [correctAnswer];
      while (choices.length < 3) {
        int randomChoice = random.nextInt(20) + 1; // Generate choices up to 20
        if (!choices.contains(randomChoice)) {
          choices.add(randomChoice);
        }
      }
      choices.shuffle();

      allQuestions.add({
        "question": "$num1 - $num2 = ?",
        "answer": correctAnswer,
        "choices": choices,
      });
    }

    allQuestions.shuffle(); // Randomize the question order

    return allQuestions;
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == questions[currentIndex]['answer']) {
      setState(() {
        score++;
        if (currentIndex < questions.length - 1) {
          currentIndex++;
        } else {
          showGameOverAlert(context);
        }
      });
    } else {
      showErrorAlert(context);
    }
  }

  void showGameOverAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Game Over!",
      desc: "Your final score is: $score / ${questions.length}",
      buttons: [
        DialogButton(
          child: const Text(
            "Play Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context); // Close the alert
            resetGame();
          },
          width: 120,
        )
      ],
    ).show();
  }

  void showErrorAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Incorrect!",
      desc: "Try Again!",
      buttons: [
        DialogButton(
          child: const Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void resetGame() {
    setState(() {
      currentIndex = 0;
      score = 0;
      questions = generateQuestions(); // Regenerate question list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back/backShapes.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: IconButton(
              icon: Image.asset("assets/icons/cancel.png", width: 35),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  questions[currentIndex]['question'],
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Boogaloo',
                    color: Color.fromARGB(255, 73, 71, 71),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    questions[currentIndex]['choices'].length,
                    (index) => GestureDetector(
                      onTap: () =>
                          checkAnswer(questions[currentIndex]['choices'][index]),
                      child: Text(
                        questions[currentIndex]['choices'][index].toString(),
                        style: TextStyle(
                          fontFamily: 'LuckiestGuy',
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.primaries[
                              index % Colors.primaries.length],
                          shadows: const [
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Score: $score",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
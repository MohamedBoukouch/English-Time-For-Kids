import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

class DivisionPage extends StatefulWidget {
  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  final Random random = Random();
  int currentIndex = 0;
  int score = 0;

  //  Generate 30 division questions
  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions();
  }

  List<Map<String, dynamic>> generateQuestions() {
    List<Map<String, dynamic>> allQuestions = [];

    while (allQuestions.length < 30) {
      int correctAnswer = random.nextInt(8) + 1;  // Generate possible correct answers (1 to 8 to avoid excessively large dividends)
      int num2 = random.nextInt(8) + 1; // Generate a divisor between 1 and 8
      int num1 = correctAnswer * num2;  // Calculate the dividend

      // Ensure choices are distinct and don't include duplicates
      List<int> choices = [correctAnswer];
      while (choices.length < 3) {
        int randomChoice = random.nextInt(10) + 1; // Generate choices (up to 10)
        if (!choices.contains(randomChoice)) {
          choices.add(randomChoice);
        }
      }
      choices.shuffle();

      allQuestions.add({
        "question": "$num1 ÷ $num2 = ?",
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
              'assets/backgrounds/mathBack.webp',
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
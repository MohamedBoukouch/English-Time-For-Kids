import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

class FindNumber extends StatefulWidget {
  @override
  _FindNumberState createState() => _FindNumberState();
}

class _FindNumberState extends State<FindNumber> {
  final Random random = Random();
  int currentIndex = 0;
  int score = 0;

  // Initial question list
  final List<Map<String, dynamic>> initialQuestions = [
    {"word": "One", "answer": 1, "choices": [1, 2, 3]},
    {"word": "Two", "answer": 2, "choices": [2, 4, 5]},
    {"word": "Three", "answer": 3, "choices": [3, 6, 7]},
    {"word": "Four", "answer": 4, "choices": [4, 8, 9]},
    {"word": "Five", "answer": 5, "choices": [5, 10, 11]},
  ];

  // Expand to 100 random questions
  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = generateQuestions();
  }

  List<Map<String, dynamic>> generateQuestions() {
    List<Map<String, dynamic>> allQuestions =
        List.from(initialQuestions); // Start with the initial questions

    // Generate random questions until we reach 100
    while (allQuestions.length < 100) {
      int correctAnswer = random.nextInt(100) + 1; // Generate numbers up to 100
      List<int> choices = [correctAnswer];

      while (choices.length < 3) {
        int randomChoice = random.nextInt(100) + 1;
        if (!choices.contains(randomChoice)) {
          choices.add(randomChoice);
        }
      }
      choices.shuffle();

      String word;
      if (correctAnswer <= 5) {
        // Ensure there's no duplicate of initial questions by re-using only the words
        word = initialQuestions[correctAnswer - 1]["word"];
      } else {
        word = numberToWord(correctAnswer);
      }

      allQuestions.add({
        "word": word,
        "answer": correctAnswer,
        "choices": choices,
      });
    }

    allQuestions.shuffle(); // Randomize the entire list

    return allQuestions;
  }

  String numberToWord(int number) {
    const ones = [
      "",
      "One",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Eleven",
      "Twelve",
      "Thirteen",
      "Fourteen",
      "Fifteen",
      "Sixteen",
      "Seventeen",
      "Eighteen",
      "Nineteen"
    ];
    const tens = [
      "",
      "",
      "Twenty",
      "Thirty",
      "Forty",
      "Fifty",
      "Sixty",
      "Seventy",
      "Eighty",
      "Ninety"
    ];

    if (number < 20) {
      return ones[number];
    } else if (number < 100) {
      return tens[number ~/ 10] +
          ((number % 10 != 0) ? " " + ones[number % 10] : "");
    } else {
      return "One Hundred"; // Assuming the maximum number is 100
    }
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == questions[currentIndex]['answer']) {
      setState(() {
        score++;
        if (currentIndex < questions.length - 1) {
          currentIndex++;
        } else {
          // Game Over Logic - Navigate to a game over screen or show a dialog
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
              'assets/backgrounds/backShapes.jpg',
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
                  questions[currentIndex]['word'],
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
                      onTap: () => checkAnswer(
                          questions[currentIndex]['choices'][index]),
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
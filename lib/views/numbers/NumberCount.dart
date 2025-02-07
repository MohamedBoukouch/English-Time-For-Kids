import 'package:english_for_kids/configs/constant.dart';
import 'package:flutter/material.dart';

class NumberCount extends StatefulWidget {
  const NumberCount({super.key});

  @override
  _NumberCountState createState() => _NumberCountState();
}

class _NumberCountState extends State<NumberCount> {
  // Manually creating the list of numbers (0 to 100)
  final List<String> numberList = List.generate(101, (index) => '$index');  // Generates numbers from 0 to 100

  int _currentIndex = 0;

  // Function to move to the next number in the list
  void _nextNumber() {
    setState(() {
      if (_currentIndex < numberList.length - 1) {
        _currentIndex++;
      }
    });
  }

  // Function to move to the previous number in the list
  void _previousNumber() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (tableau.jpg)
          Positioned.fill(
            child: Image.asset(
              'assets/tableau.jpg',
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
          
          // Number Display (0 to 100)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                numberList[_currentIndex],  // Display current number from the list
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 250, // Adjust the font size as needed
                  fontFamily: 'Boogaloo'
                ),
              ),
            ),
          ),

          // Next Icon Button to change the number (positioned on the right)
          

          // Back Icon Button to go to the previous number (positioned at the center left)
            Positioned(
            right: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Centre verticalement
            child: IconButton(
              icon: Image.asset(
                "assets/icons/next.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _nextNumber,
            ),
          ),



          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Centre verticalement
            child: IconButton(
              icon: Image.asset(
                "assets/icons/back.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _previousNumber,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AlphanetsView extends StatefulWidget {
  const AlphanetsView({super.key});

  @override
  _AlphanetsViewState createState() => _AlphanetsViewState();
}

class _AlphanetsViewState extends State<AlphanetsView> {
  // Manually creating the list of alphabets (A to Z)
  final List<String> alphabetList = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", 
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  ];

  int _currentIndex = 0;

  // Function to move to the next image in the list
  void _nextImage() {
    setState(() {
      if (_currentIndex < alphabetList.length - 1) {
        _currentIndex++;
      }
    });
  }

  // Function to move to the previous image in the list
  void _previousImage() {
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

          // Alphabet Image Display (A.png to Z.png)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                alphabetList[_currentIndex],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 260,
                  fontFamily: 'NotoSerif'
                ),
              ),
            ),
          ),

          // Next Icon Button to change the alphabet (positioned on the right)
          Positioned(
            bottom: 30,
            right: 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, size: 40, color: Colors.white),
              onPressed: _nextImage, // Trigger the next image on press
            ),
          ),

          // Back Icon Button to go to the previous character (positioned at the center left)
          Positioned(
            bottom: 30,
            left: 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
              onPressed: _previousImage, // Trigger the previous image on press
            ),
          ),
        ],
      ),
    );
  }
}

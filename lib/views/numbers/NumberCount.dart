import 'package:english_for_kids/configs/constant.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumberCount extends StatefulWidget {
  const NumberCount({super.key});

  @override
  _NumberCountState createState() => _NumberCountState();
}

class _NumberCountState extends State<NumberCount> {
  final List<String> numberList = List.generate(31, (index) => '$index'); // Numbers from 0 to 30

  final List<Color> numberColors = [
    Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple,
    Colors.pink, Colors.teal, Colors.cyan, Colors.lime, Colors.indigo,
    Colors.amber, Colors.brown, Colors.deepOrange, Colors.deepPurple,
    Colors.lightBlue, Colors.lightGreen, Colors.yellow, Colors.grey,
    Colors.blueGrey, Colors.redAccent, Colors.blueAccent, Colors.black,
    Colors.lightBlueAccent, Colors.lightGreenAccent, Colors.deepOrangeAccent, Colors.indigoAccent,
    Colors.tealAccent, Colors.purpleAccent, Colors.orangeAccent, Colors.greenAccent, Colors.brown
  ]; // At least 31 colors

  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  @override
  void initState() {
    super.initState();
    _playSound(); // Play sound for the first number on page load
  }

  // Function to play the sound for the current number
  Future<void> _playSound() async {
    String soundPath = "songs/numbers/${numberList[_currentIndex]}.m4a";
    await _audioPlayer.stop(); // Stop previous sound before playing new one
    await _audioPlayer.play(AssetSource(soundPath));
  }

  // Function to go to the next number and play its sound
  void _nextNumber() {
    setState(() {
      if (_currentIndex < numberList.length - 1) {
        _currentIndex++;
        _playSound();
      }
    });
  }

  // Function to go to the previous number and play its sound
  void _previousNumber() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playSound();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release audio resources when exiting
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/mathBack.webp',
              fit: BoxFit.cover,
            ),
          ),

          // Close Button
          Positioned(
            top: 40,
            right: 30,
            child: IconButton(
              icon: Image.asset("assets/icons/cancel.png", width: 35),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Center(
            child: GestureDetector(
              onTap: _playSound, 
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  numberList[_currentIndex], 
                  style: TextStyle(
                    color: numberColors[_currentIndex], // Updated to ensure enough colors
                    fontWeight: FontWeight.bold,
                    fontSize: 250, 
                    fontFamily: 'Boogaloo',
                  ),
                ),
              ),
            ),
          ),

          // Previous Button (Left)
          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Center vertically
            child: IconButton(
              icon: Image.asset(
                "assets/icons/back.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _previousNumber,
            ),
          ),

          // Next Button (Right)
          Positioned(
            right: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Center vertically
            child: IconButton(
              icon: Image.asset(
                "assets/icons/next.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _nextNumber,
            ),
          ),
        ],
      ),
    );
  }
}

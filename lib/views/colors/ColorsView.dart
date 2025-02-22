import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audio player package
import '../../configs/constant.dart';

class ColorsView extends StatefulWidget {
  const ColorsView({super.key});

  @override
  _ColorsViewState createState() => _ColorsViewState();
}

class _ColorsViewState extends State<ColorsView> {
  final List<Map<String, dynamic>> colorsList = [
    {"title": "Red", "color": Colors.red, "audio": "red.m4a"},
    {"title": "Blue", "color": Colors.blue, "audio": "blue.m4a"},
    {"title": "Yellow", "color": Colors.yellow, "audio": "yellow.m4a"},
    {"title": "Green", "color": Colors.green, "audio": "green.m4a"},
    {"title": "Pink", "color": Colors.pink, "audio": "pink.m4a"},
    {"title": "Orange", "color": Colors.orange, "audio": "orange.m4a"},
    {"title": "Purple", "color": Colors.purple, "audio": "purple.m4a"},
    {"title": "Teal", "color": Colors.teal, "audio": "teal.m4a"},
    {"title": "Brown", "color": Colors.brown, "audio": "brown.m4a"},
    {"title": "Black", "color": Colors.black, "audio": "black.m4a"},
  ];

  int _currentIndex = 0;
  AudioPlayer _audioPlayer = AudioPlayer();  // Initialize the audio player

  // Function to play the color audio
  void _playColorAudio(String colorAudio) async {
    await _audioPlayer.stop();  // Stop any currently playing audio
    await _audioPlayer.play(AssetSource('songs/colors/$colorAudio'));  // Play the corresponding color audio file
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < colorsList.length - 1) {
        _currentIndex++;
        _playColorAudio(colorsList[_currentIndex]["audio"]); // Play the audio for the next color
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playColorAudio(colorsList[_currentIndex]["audio"]); // Play the audio for the previous color
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shape = colorsList[_currentIndex];

    // Ensure the first color's audio plays when the page loads
    if (_currentIndex == 0) {
      _playColorAudio(colorsList[_currentIndex]["audio"]);
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backShapes.webp',
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
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _playColorAudio(shape["audio"]); // Play the audio when the image is tapped
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        "assets/colors/color_forme.png",
                        width: AppConstantes.screenWidth(context) * .40,
                        color: shape["color"],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    shape["title"],
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: shape["color"],
                      fontFamily: 'Boogaloo',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bouton "Back" aligné au centre gauche
          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Centre verticalement
            child: IconButton(
              icon: Image.asset(
                "assets/icons/back.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _previousImage,
            ),
          ),

          // Bouton "Next" aligné au centre droit
          Positioned(
            right: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Centre verticalement
            child: IconButton(
              icon: Image.asset(
                "assets/icons/next.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _nextImage,
            ),
          ),
        ],
      ),
    );
  }
}

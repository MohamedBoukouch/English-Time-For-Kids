import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class VegetablesView extends StatefulWidget {
  const VegetablesView({super.key});

  @override
  _VegetablesViewState createState() => _VegetablesViewState();
}

class _VegetablesViewState extends State<VegetablesView> {
  int _currentIndex = 0;
  bool _isLoading = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> shapesList = [
    {"image": "tomato.webp", "title": "Tomato", "size": 0.32, "audio": "Tomato.m4a"},
    {"image": "cucumber.webp", "title": "Pumpkin", "size": 0.4, "audio": "Pumpkin.m4a"},
    {"image": "beetroot.webp", "title": "Beetroot", "size": 0.37, "audio": "Beetroot.m4a"},
    {"image": "broccoli.webp", "title": "Broccoli", "size": 0.3, "audio": "Broccoli.m4a"},
    {"image": "capsicum.webp", "title": "Capsicum", "size": 0.45, "audio": "Capsicum.m4a"},
    {"image": "carrot.webp", "title": "Carrot", "size": 0.5, "audio": "Carrot.m4a"},
    {"image": "cauliflower.webp", "title": "Cauliflower", "size": 0.3, "audio": "Cauliflower.m4a"},
    {"image": "eggplant.webp", "title": "Eggplant", "size": 0.35, "audio": "Eggplant.m4a"},
    {"image": "garlic.webp", "title": "Garlic", "size": 0.38, "audio": "Garlic.m4a"},
    {"image": "onion.webp", "title": "Onion", "size": 0.33, "audio": "Onion.m4a"},
    {"image": "pepper.webp", "title": "Pepper", "size": 0.38, "audio": "Pepper.m4a"},
    {"image": "potato.webp", "title": "Potato", "size": 0.38, "audio": "Potato.m4a"},
    {"image": "pumpkin.webp", "title": "Pumpkin", "size": 0.46, "audio": "Pumpkin.m4a"},
  ];

  @override
  void initState() {
    super.initState();
    _playCurrentAudio(); // Play the default vegetable sound when the page starts
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCurrentAudio() async {
    String audioPath = "songs/vegetables/${shapesList[_currentIndex]['audio']}";
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(audioPath));
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playCurrentAudio(); // Play sound when changing vegetable
      }
    });
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < shapesList.length - 1) {
        _currentIndex++;
        _playCurrentAudio(); // Play sound when changing vegetable
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shape = shapesList[_currentIndex];
    final double imageSize = AppConstantes.screenWidth(context) * shape["size"];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backFerm.webp',
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
              children: [
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: _playCurrentAudio, // Play sound when tapping on image
                        child: Image.asset(
                          "assets/vegetables/${shape["image"]}",
                          width: imageSize,
                        ),
                      ),
                const SizedBox(height: 10),
                Text(
                  shape["title"],
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Boogaloo',
                    shadows: [
                      Shadow(offset: Offset(-2, -2), color: Colors.amber),
                      Shadow(offset: Offset(2, -2), color: Colors.amber),
                      Shadow(offset: Offset(-2, 2), color: Colors.amber),
                      Shadow(offset: Offset(2, 2), color: Colors.amber),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 30,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: Image.asset(
                "assets/icons/back.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _previousImage,
            ),
          ),
          Positioned(
            right: 30,
            top: MediaQuery.of(context).size.height / 2 - 30,
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

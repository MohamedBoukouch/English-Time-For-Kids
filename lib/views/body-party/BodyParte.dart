import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class BodyParts extends StatefulWidget {
  const BodyParts({super.key});

  @override
  _BodyPartsState createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> bodyPartsList = [
    {"image": "head.png", "title": "Head", "size": .28, "sound": "Head.m4a"},
    {"image": "eye.png", "title": "Eye", "size": .31, "sound": "Eye.m4a"},
    {"image": "nose.png", "title": "Nose", "size": .33, "sound": "Nose.m4a"},
    {"image": "mouth.png", "title": "Mouth", "size": .35, "sound": "Mouth.m4a"},
    {"image": "leg.png", "title": "Leg", "size": .28, "sound": "Leg.m4a"},
    {"image": "knee.png", "title": "Knee", "size": .3, "sound": "Knee.m4a"},
    {"image": "hand.png", "title": "Hand", "size": .24, "sound": "Hand.m4a"},
    {"image": "foot.png", "title": "Foot", "size": .22, "sound": "Foot.m4a"},
    {"image": "ear.png", "title": "Ear", "size": .32, "sound": "Ear.m4a"},
    {"image": "arm.png", "title": "Arm", "size": .26, "sound": "Arm.m4a"},
  ];

  @override
  void initState() {
    super.initState();
    _playSound(bodyPartsList[_currentIndex]["sound"]); // Play first sound on load
  }

  void _playSound(String soundFile) async {
    await _audioPlayer.stop(); // Stop any previous sound
    await _audioPlayer.play(AssetSource("songs/body_parts/$soundFile")); // Play new sound
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _playSound(bodyPartsList[_currentIndex]["sound"]);
    }
  }

  void _nextImage() {
    if (_currentIndex < bodyPartsList.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _playSound(bodyPartsList[_currentIndex]["sound"]);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release audio resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shape = bodyPartsList[_currentIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Stack(
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
              child: GestureDetector(
                onTap: () => _playSound(shape["sound"]), // Play sound on image tap
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/body/${shape["image"]}",
                      width: AppConstantes.screenWidth(context) * shape["size"],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 50),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        shape["title"],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Boogaloo',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: AppConstantes.screenHeight(context) / 2 - 30,
              child: IconButton(
                icon: Image.asset("assets/icons/back.png", width: AppConstantes.screenWidth(context) * .1),
                onPressed: _previousImage,
              ),
            ),
            Positioned(
              right: 30,
              top: AppConstantes.screenHeight(context) / 2 - 30,
              child: IconButton(
                icon: Image.asset("assets/icons/next.png", width: AppConstantes.screenWidth(context) * .1),
                onPressed: _nextImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

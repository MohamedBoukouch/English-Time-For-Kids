import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class FruitsView extends StatefulWidget {
  const FruitsView({super.key});

  @override
  _FruitsViewState createState() => _FruitsViewState();
}

class _FruitsViewState extends State<FruitsView> {
  int _currentIndex = 0;
  bool _isLoading = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> fruitList = [
    {"image": "apple.png", "title": "Apple", "size": 0.37},
    {"image": "orange.png", "title": "Orange", "size": 0.4},
    {"image": "banana.png", "title": "Banana", "size": 0.38},
    {"image": "kiwi.png", "title": "Kiwi", "size": 0.38},
    {"image": "jackfruit.png", "title": "Jackfruit", "size": 0.4},
    {"image": "grapes.png", "title": "Grapes", "size": 0.38},
    {"image": "figs.png", "title": "Figs", "size": 0.4},
    {"image": "coconut.png", "title": "Coconut", "size": 0.34},
    {"image": "cherry.png", "title": "Cherry", "size": 0.26},
    {"image": "blueberry.png", "title": "Blueberry", "size": 0.45},
    {"image": "avocado.png", "title": "Avocado", "size": 0.4},
    {"image": "watermelon.png", "title": "Watermelon", "size": 0.4},
    {"image": "strawberry.png", "title": "Strawberry", "size": 0.42},
    {"image": "raspberry.png", "title": "Raspberry", "size": 0.54},
    {"image": "pomegranate.png", "title": "Pomegranate", "size": 0.34},
    {"image": "pineapple.png", "title": "Pineapple", "size": 0.25},
    {"image": "pear.png", "title": "Pear", "size": 0.36},
    {"image": "papaya.png", "title": "Papaya", "size": 0.39},
    {"image": "mango.png", "title": "Mango", "size": 0.48},
    {"image": "litchi.png", "title": "Litchi", "size": 0.59},
  ];

  @override
  void initState() {
    super.initState();
    _playFruitSound();
  }

  void _playFruitSound() async {
    final fruit = fruitList[_currentIndex];
    final soundPath = "songs/fruits/${fruit["title"]}.m4a";

    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < fruitList.length - 1) {
        _currentIndex++;
        _isLoading = true;
        _playFruitSound();
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _isLoading = true;
        _playFruitSound();
      }
    });
  }

  void _replaySound() {
    _playFruitSound();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fruit = fruitList[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backFerm.jpg',
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
                GestureDetector(
                  onTap: _replaySound,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_isLoading) CircularProgressIndicator(),
                      Image.asset(
                        "assets/fruits/${fruit["image"]}",
                        width: AppConstantes.screenWidth(context) * fruit["size"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50, color: Colors.red),
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (frame == null) {
                            return CircularProgressIndicator();
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() => _isLoading = false);
                          });
                          return child;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  fruit["title"],
                  style: TextStyle(
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
    );
  }
}

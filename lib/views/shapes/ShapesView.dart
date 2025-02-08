import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class Shapesview extends StatefulWidget {
  const Shapesview({super.key});

  @override
  _ShapesviewState createState() => _ShapesviewState();
}

class _ShapesviewState extends State<Shapesview> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> shapesList = [
    {"image": "speral.png", "title": "Spiral", "color": Colors.grey, "size": 0.25, "sound": "spiral.m4a"},
    {"image": "square.webp", "title": "Square", "color": Colors.blueGrey, "size": 0.3, "sound": "square.m4a"},
    {"image": "star.png", "title": "Star", "color": Colors.amber, "size": 0.3, "sound": "star.m4a"},
    {"image": "triangle.png", "title": "Triangle", "color": Colors.lime, "size": 0.33, "sound": "triangle.m4a"},
    {"image": "arrow.png", "title": "Arrow", "color": Colors.red, "size": 0.23, "sound": "arrow.m4a"},
    {"image": "circle.png", "title": "Circle", "color": Colors.blue, "size": 0.3, "sound": "circle.m4a"},
    {"image": "crescent.png", "title": "Crescent", "color": Colors.yellow, "size": 0.3, "sound": "crescent.m4a"},
    {"image": "cube.png", "title": "Cube", "color": Colors.green, "size": 0.3, "sound": "cube.m4a"},
    {"image": "heart.png", "title": "Heart", "color": Colors.pink, "size": 0.3, "sound": "heart.m4a"},
    {"image": "hexagon.png", "title": "Hexagon", "color": Colors.orange, "size": 0.25, "sound": "hexagon.m4a"},
    {"image": "pentagon.png", "title": "Pentagon", "color": Colors.purple, "size": 0.3, "sound": "pentagon.m4a"},
    {"image": "parallelogram.png", "title": "Parallelogram", "color": Colors.teal, "size": 0.3, "sound": "parallelogram.m4a"},
    {"image": "oval.png", "title": "Oval", "color": Colors.cyan, "size": 0.3, "sound": "oval.m4a"},
    {"image": "rectangle.png", "title": "Rectangle", "color": Colors.brown, "size": 0.42, "sound": "rectangle.m4a"},
    {"image": "rhombus.png", "title": "Rhombus", "color": Colors.indigo, "size": 0.3, "sound": "rhombus.m4a"},
    {"image": "right_triangle.png", "title": "Right Triangle", "color": Colors.deepPurple, "size": 0.3, "sound": "right_triangle.m4a"},
  ];

  void _playSound(String soundFileName) async {
    await _audioPlayer.stop(); // Stop any playing sound before starting a new one
    await _audioPlayer.play(AssetSource("songs/shapes/$soundFileName"));
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playSound(shapesList[_currentIndex]["sound"]);
      }
    });
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < shapesList.length - 1) {
        _currentIndex++;
        _playSound(shapesList[_currentIndex]["sound"]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Play "Spiral" sound when the page opens
    Future.delayed(Duration.zero, () {
      _playSound(shapesList[0]["sound"]);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shape = shapesList[_currentIndex];

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
            child: GestureDetector(
              onTap: () => _playSound(shape["sound"]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/shapes/${shape["image"]}",
                    width: AppConstantes.screenWidth(context) * shape["size"],
                    color: shape["color"],
                  ),
                  const SizedBox(height: 20),
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

          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30,
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
            top: AppConstantes.screenHeight(context) / 2 - 30,
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

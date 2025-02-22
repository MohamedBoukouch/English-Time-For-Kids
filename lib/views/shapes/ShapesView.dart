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
  bool _isLoading = true; // Track loading state

  final List<Map<String, dynamic>> shapesList = [
    {"image": "speral.webp", "title": "Spiral", "color": Colors.grey, "size": 0.25, "sound": "spiral.m4a"},
    {"image": "square.webp", "title": "Square", "color": Colors.blueGrey, "size": 0.3, "sound": "square.m4a"},
    {"image": "star.webp", "title": "Star", "color": Colors.amber, "size": 0.3, "sound": "star.m4a"},
    {"image": "triangle.webp", "title": "Triangle", "color": Colors.lime, "size": 0.33, "sound": "triangle.m4a"},
    {"image": "arrow.webp", "title": "Arrow", "color": Colors.red, "size": 0.23, "sound": "arrow.m4a"},
    {"image": "circle.webp", "title": "Circle", "color": Colors.blue, "size": 0.3, "sound": "circle.m4a"},
    {"image": "crescent.webp", "title": "Crescent", "color": Colors.yellow, "size": 0.3, "sound": "crescent.m4a"},
    {"image": "cube.webp", "title": "Cube", "color": Colors.green, "size": 0.3, "sound": "cube.m4a"},
    {"image": "heart.webp", "title": "Heart", "color": Colors.pink, "size": 0.3, "sound": "heart.m4a"},
    {"image": "hexagon.webp", "title": "Hexagon", "color": Colors.orange, "size": 0.25, "sound": "hexagon.m4a"},
    {"image": "pentagon.webp", "title": "Pentagon", "color": Colors.purple, "size": 0.3, "sound": "pentagon.m4a"},
    {"image": "parallelogram.webp", "title": "Parallelogram", "color": Colors.teal, "size": 0.3, "sound": "parallelogram.m4a"},
    {"image": "oval.webp", "title": "Oval", "color": Colors.cyan, "size": 0.3, "sound": "oval.m4a"},
    {"image": "rectangle.webp", "title": "Rectangle", "color": Colors.brown, "size": 0.42, "sound": "rectangle.m4a"},
    {"image": "rhombus.webp", "title": "Rhombus", "color": Colors.indigo, "size": 0.3, "sound": "rhombus.m4a"},
    {"image": "right_triangle.webp", "title": "Right Triangle", "color": Colors.deepPurple, "size": 0.3, "sound": "right_triangle.m4a"},
  ];

  void _playSound(String soundFileName) async {
    setState(() => _isLoading = true);
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("songs/shapes/$soundFileName"));
    setState(() => _isLoading = false);
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _playSound(shapesList[_currentIndex]["sound"]);
      });
    }
  }

  void _nextImage() {
    if (_currentIndex < shapesList.length - 1) {
      setState(() {
        _currentIndex++;
        _playSound(shapesList[_currentIndex]["sound"]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
            child: _isLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () => _playSound(shape["sound"]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/shapes/${shape["image"]}",
                          width: AppConstantes.screenWidth(context) * shape["size"],
                          color: shape["color"],
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (frame == null) {
                              return CircularProgressIndicator();
                            }
                            return child;
                          },
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

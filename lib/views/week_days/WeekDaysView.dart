import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class WeekDaysView extends StatefulWidget {
  const WeekDaysView({super.key});

  @override
  _WeekDaysViewState createState() => _WeekDaysViewState();
}

class _WeekDaysViewState extends State<WeekDaysView> {
  final List<Map<String, dynamic>> colorsList = [
    {"title": "Monday", "color": Colors.red},
    {"title": "Tuesday", "color": Colors.blue},
    {"title": "Wednesday", "color": Colors.yellow},
    {"title": "Thursday", "color": Colors.green},
    {"title": "Friday", "color": Colors.pink},
    {"title": "Saturday", "color": Colors.orange},
    {"title": "Sunday", "color": Colors.purple},
  ];

  int _currentIndex = 0;

  void _nextImage() {
    setState(() {
      if (_currentIndex < colorsList.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shape = colorsList[_currentIndex];

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
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image
                Image.asset(
                  "assets/colors/color_forme.png",
                  width: AppConstantes.screenWidth(context) * .40,
                  color: shape["color"],
                ),

                // Title on top of the image
                Text(
                  shape["title"],
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for better visibility
                    fontFamily: 'Boogaloo',
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // "Back" button (left side)
          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Center vertically
            child: IconButton(
              icon: Image.asset(
                "assets/icons/back.png",
                width: AppConstantes.screenWidth(context) * .1,
              ),
              onPressed: _previousImage,
            ),
          ),

          // "Next" button (right side)
          Positioned(
            right: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30, // Center vertically
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

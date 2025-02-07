import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class ColorsView extends StatefulWidget {
  const ColorsView({super.key});

  @override
  _ColorsViewState createState() => _ColorsViewState();
}

class _ColorsViewState extends State<ColorsView> {
  final List<Map<String, dynamic>> colorsList = [
    {"title": "Red", "color": Colors.red},
    {"title": "Blue", "color": Colors.blue},
    {"title": "Yellow", "color": Colors.yellow},
    {"title": "Green", "color": Colors.green},
    {"title": "Pink", "color": Colors.pink},
    {"title": "Orange", "color": Colors.orange},
    {"title": "Purple", "color": Colors.purple},
    {"title": "Teal", "color": Colors.teal},
    {"title": "Brown", "color": Colors.brown},
    {"title": "Black", "color": Colors.black},
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
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      "assets/colors/color_forme.png",
                      width: AppConstantes.screenWidth(context) * .40,
                      color: shape["color"],
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

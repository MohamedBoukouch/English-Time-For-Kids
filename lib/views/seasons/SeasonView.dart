import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class SeasonView extends StatefulWidget {
  const SeasonView({super.key});

  @override
  _SeasonViewState createState() => _SeasonViewState();
}

class _SeasonViewState extends State<SeasonView> {


  int _currentIndex = 0;



  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

final List<Map<String, dynamic>> shapesList = [
  {"image": "spring.avif", "title": "Spring", "color": Colors.green, "size": AppConstantes.screenWidth(context) * .31},
  {"image": "summer.jpg", "title": "Summer", "color": Colors.yellow, "size": AppConstantes.screenWidth(context) * .31},
  {"image": "winter.jpg", "title": "Winter", "color": Colors.blue, "size": AppConstantes.screenWidth(context) * .34},
  {"image": "autumn.avif", "title": "Autumn", "color": Colors.brown, "size": AppConstantes.screenWidth(context) * .31},
];


  void _nextImage() {
    setState(() {
      if (_currentIndex < shapesList.length - 1) {
        _currentIndex++;
      }
    });
  }

    final shape = shapesList[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backShapes.jpg',
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
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 88, 85, 85), // White border color
                      width: 4, // Border thickness
                    ),
                    borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        "assets/seasons/${shape["image"]}",
                        width: shape["size"],
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
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

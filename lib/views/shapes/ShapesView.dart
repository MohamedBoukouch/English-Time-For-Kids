import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class Shapesview extends StatefulWidget {
  const Shapesview({super.key});

  @override
  _ShapesviewState createState() => _ShapesviewState();
}

class _ShapesviewState extends State<Shapesview> {


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
  {"image": "speral.png", "title": "Spiral", "color": Colors.grey, "size": AppConstantes.screenWidth(context) * .25},
  {"image": "square.webp", "title": "Square", "color": Colors.blueGrey, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "star.png", "title": "Star", "color": Colors.amber, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "triangle.png", "title": "Triangle", "color": Colors.lime, "size": AppConstantes.screenWidth(context) * .33},
  {"image": "arrow.png", "title": "Arrow", "color": Colors.red, "size": AppConstantes.screenWidth(context) * .23},
  {"image": "circle.png", "title": "Circle", "color": Colors.blue, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "crescent.png", "title": "Crescent", "color": Colors.yellow, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "cube.png", "title": "Cube", "color": Colors.green, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "heart.png", "title": "Heart", "color": Colors.pink, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "hexagon.png", "title": "Hexagon", "color": Colors.orange, "size": AppConstantes.screenWidth(context) * .25},
  {"image": "pentagon.png", "title": "Pentagon", "color": Colors.purple, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "parallelogram.png", "title": "Parallelogram", "color": Colors.teal, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "oval.png", "title": "Oval", "color": Colors.cyan, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "rectangle.png", "title": "Rectangle", "color": Colors.brown, "size": AppConstantes.screenWidth(context) * .42},
  {"image": "rhombus.png", "title": "Rhombus", "color": Colors.indigo, "size": AppConstantes.screenWidth(context) * .3},
  {"image": "right_triangle.png", "title": "Right Triangle", "color": Colors.deepPurple, "size": AppConstantes.screenWidth(context) * .3},
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
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      "assets/shapes/${shape["image"]}",
                      width: shape["size"],
                      color: shape["color"],
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

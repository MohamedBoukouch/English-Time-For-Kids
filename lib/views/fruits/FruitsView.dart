import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class FruitsView extends StatefulWidget {
  const FruitsView({super.key});

  @override
  _FruitsViewState createState() => _FruitsViewState();
}

class _FruitsViewState extends State<FruitsView> {


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

final List<Map<String, dynamic>> fruitList = [
  {"image": "apple.png", "title": "Apple", "size": AppConstantes.screenWidth(context) * .37},
  {"image": "orange.png", "title": "Orange",  "size": AppConstantes.screenWidth(context) * .4},
  {"image": "banana.png", "title": "Banana", "size": AppConstantes.screenWidth(context) * .38},
  {"image": "kiwi.png", "title": "Kiwi",  "size": AppConstantes.screenWidth(context) * .38},
  {"image": "jackfruit.png", "title": "Jackfruit",  "size": AppConstantes.screenWidth(context) * .4},
  {"image": "grapes.png", "title": "Grapes", "size": AppConstantes.screenWidth(context) * .38},
  {"image": "figs.png", "title": "Figs",  "size": AppConstantes.screenWidth(context) * .4},
  {"image": "coconut.png", "title": "Coconut", "size": AppConstantes.screenWidth(context) * .34},
  {"image": "cherry.png", "title": "Cherry", "size": AppConstantes.screenWidth(context) * .26},
  {"image": "blueberry.png", "title": "Blueberry", "size": AppConstantes.screenWidth(context) * .45},
  {"image": "avocado.png", "title": "Avocado", "size": AppConstantes.screenWidth(context) * .4},
  {"image": "watermelon.png", "title": "Watermelon", "size": AppConstantes.screenWidth(context) * .4},
  {"image": "strawberry.png", "title": "Strawberry", "size": AppConstantes.screenWidth(context) * .42},
  {"image": "raspberry.png", "title": "Raspberry",  "size": AppConstantes.screenWidth(context) * .54},
  {"image": "pomegranate.png", "title": "Pomegranate",  "size": AppConstantes.screenWidth(context) * .34},
  {"image": "pineapple.png", "title": "Pineapple",  "size": AppConstantes.screenWidth(context) * .25},
  {"image": "pear.png", "title": "Pear",  "size": AppConstantes.screenWidth(context) * .36},
  {"image": "papaya.png", "title": "Oapaya",  "size": AppConstantes.screenWidth(context) * .39},
  {"image": "mango.png", "title": "Mango",  "size": AppConstantes.screenWidth(context) * .48},
  {"image": "litchi.png", "title": "Litchi",  "size": AppConstantes.screenWidth(context) * .59},
];


  void _nextImage() {
    setState(() {
      if (_currentIndex < fruitList.length - 1) {
        _currentIndex++;
      }
    });
  }

    final shape = fruitList[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back/backFerm.jpg',
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
                      "assets/fruits/${shape["image"]}",
                      width: shape["size"],
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    shape["title"],
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text color
                      fontFamily: 'Boogaloo',
                      shadows: [
                        Shadow(
                          offset: Offset(-2, -2),
                          color: Colors.amber, // Gold color on the top-left
                        ),
                        Shadow(
                          offset: Offset(2, -2),
                          color: Colors.amber, // Gold color on the top-right
                        ),
                        Shadow(
                          offset: Offset(-2, 2),
                          color: Colors.amber, // Gold color on the bottom-left
                        ),
                        Shadow(
                          offset: Offset(2, 2),
                          color: Colors.amber, // Gold color on the bottom-right
                        ),
                      ],
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

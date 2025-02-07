import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class VegetablesView extends StatefulWidget {
  const VegetablesView({super.key});

  @override
  _VegetablesViewState createState() => _VegetablesViewState();
}

class _VegetablesViewState extends State<VegetablesView> {


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
  {"image": "tomato.png", "title": "Tomato",  "size": AppConstantes.screenWidth(context) * .32},
  {"image": "cucumber.png", "title": "Pumpkin",  "size": AppConstantes.screenWidth(context) * .4},
  {"image": "beetroot.png", "title": "Beetroot", "size": AppConstantes.screenWidth(context) * .37},
  {"image": "broccoli.png", "title": "Broccoli",  "size": AppConstantes.screenWidth(context) * .3},
  {"image": "capsicum.png", "title": "Capsicum", "size": AppConstantes.screenWidth(context) * .45},
  {"image": "carrot.png", "title": "Carrot", "size": AppConstantes.screenWidth(context) * .5},
  {"image": "cauliflower.png", "title": "Cauliflower", "size": AppConstantes.screenWidth(context) * .3},
  {"image": "eggplant.png", "title": "Eggplant", "size": AppConstantes.screenWidth(context) * .35},
  {"image": "garlic.png", "title": "Garlic", "size": AppConstantes.screenWidth(context) * .38},
  {"image": "onion.png", "title": "Onion", "size": AppConstantes.screenWidth(context) * .33},
  {"image": "pepper.png", "title": "Pepper", "size": AppConstantes.screenWidth(context) * .38},
  {"image": "potato.png", "title": "Potato", "size": AppConstantes.screenWidth(context) * .38},
  {"image": "pumpkin.png", "title": "Pumpkin",  "size": AppConstantes.screenWidth(context) * .46},
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
                      "assets/vegetables/${shape["image"]}",
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

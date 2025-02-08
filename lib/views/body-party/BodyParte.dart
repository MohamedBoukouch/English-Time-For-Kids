import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class BodyParts extends StatefulWidget {
  const BodyParts({super.key});

  @override
  _BodyPartsState createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {


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
  {"image": "head.png", "title": "Head", "size": AppConstantes.screenWidth(context) * .28},
  {"image": "eye.png", "title": "Eye",  "size": AppConstantes.screenWidth(context) * .31},
  {"image": "nose.png", "title": "Nose", "size": AppConstantes.screenWidth(context) * .33},
  {"image": "mouth.png", "title": "Mouth Fry","size": AppConstantes.screenWidth(context) * .35},
  {"image": "leg.png", "title": "Leg Chicken",  "size": AppConstantes.screenWidth(context) * .28},
  {"image": "knee.png", "title": "Knee",  "size": AppConstantes.screenWidth(context) * .3},
  {"image": "hand.png", "title": "Hand",  "size": AppConstantes.screenWidth(context) * .24},
  {"image": "foot.png", "title": "Foot",  "size": AppConstantes.screenWidth(context) * .22},
  {"image": "ear.png", "title": "Ear",  "size": AppConstantes.screenWidth(context) * .32},
  {"image": "arm.png", "title": "Arm",  "size": AppConstantes.screenWidth(context) * .26},
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
      body: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Stack(
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
                        "assets/body/${shape["image"]}",
                        width: shape["size"],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(top:3,bottom: 3,right: 50,left: 50),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: Text(
                            shape["title"],
                            style: TextStyle(
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
      ),
    );
  }
}

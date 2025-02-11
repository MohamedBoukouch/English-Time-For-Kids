import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class VegetablesView extends StatefulWidget {
  const VegetablesView({super.key});

  @override
  _VegetablesViewState createState() => _VegetablesViewState();
}

class _VegetablesViewState extends State<VegetablesView> {
  int _currentIndex = 0;
  bool _isLoading = false;

  final List<Map<String, dynamic>> shapesList = [
    {"image": "tomato.png", "title": "Tomato", "size": 0.32},
    {"image": "cucumber.png", "title": "Pumpkin", "size": 0.4},
    {"image": "beetroot.png", "title": "Beetroot", "size": 0.37},
    {"image": "broccoli.png", "title": "Broccoli", "size": 0.3},
    {"image": "capsicum.png", "title": "Capsicum", "size": 0.45},
    {"image": "carrot.png", "title": "Carrot", "size": 0.5},
    {"image": "cauliflower.png", "title": "Cauliflower", "size": 0.3},
    {"image": "eggplant.png", "title": "Eggplant", "size": 0.35},
    {"image": "garlic.png", "title": "Garlic", "size": 0.38},
    {"image": "onion.png", "title": "Onion", "size": 0.33},
    {"image": "pepper.png", "title": "Pepper", "size": 0.38},
    {"image": "potato.png", "title": "Potato", "size": 0.38},
    {"image": "pumpkin.png", "title": "Pumpkin", "size": 0.46},
  ];

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) _currentIndex--;
    });
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < shapesList.length - 1) _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shape = shapesList[_currentIndex];
    final double imageSize = AppConstantes.screenWidth(context) * shape["size"];

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
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CircularProgressIndicator(),
                      )
                    : Image.asset(
                        "assets/vegetables/${shape["image"]}",
                        width: imageSize,
                      ),
                const SizedBox(height: 10),
                Text(
                  shape["title"],
                  style: const TextStyle(
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
            top: MediaQuery.of(context).size.height / 2 - 30,
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
            top: MediaQuery.of(context).size.height / 2 - 30,
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

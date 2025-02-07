import 'package:flutter/material.dart';
import '../../configs/constant.dart';

class Vehiclesview extends StatefulWidget {
  const Vehiclesview({super.key});

  @override
  _VehiclesviewState createState() => _VehiclesviewState();
}

class _VehiclesviewState extends State<Vehiclesview> {


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

      final List<Map<String, dynamic>> vehiclesList = [
    {"image": "aeroplane.png", "title": "Aeroplane", "size": AppConstantes.screenWidth(context) * .6},
    {"image": "ambulance.png", "title": "Ambulance", "size": AppConstantes.screenWidth(context) * .6},
    {"image": "bicycle.png", "title": "Bicycle", "size": AppConstantes.screenWidth(context) * .55},
    {"image": "boat.png", "title": "Boat", "size": AppConstantes.screenWidth(context) * .6},
    {"image": "bus.png", "title": "Bus", "size": AppConstantes.screenWidth(context) * .65},
    {"image": "car.png", "title": "Car", "size": AppConstantes.screenWidth(context) * .7},
    {"image": "helicopter.png", "title": "Helicopter", "size": AppConstantes.screenWidth(context) * .45},
    {"image": "motor_bike.png", "title": "Motor Bike", "size":AppConstantes.screenWidth(context) * .35},
    {"image": "parachute.png", "title": "Parachute", "size": AppConstantes.screenWidth(context) * .27},
    {"image": "police_car.png", "title": "Police Car", "size":AppConstantes.screenWidth(context) * .45},
    {"image": "school_bus.png", "title": "School Bus", "size": AppConstantes.screenWidth(context) * .55},
    {"image": "ship.png", "title": "Ship", "size": AppConstantes.screenWidth(context) * .6},
    {"image": "train.png", "title": "Train", "size": AppConstantes.screenWidth(context) * .47},
    {"image": "truck.png", "title": "Truck", "size": AppConstantes.screenWidth(context) * .6},
  ];

  void _nextImage() {
    setState(() {
      if (_currentIndex < vehiclesList.length - 1) {
        _currentIndex++;
      }
    });
  }

    final shape = vehiclesList[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back/backVehicles.jpg',
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
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 55, 156, 240),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      shape["title"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      "assets/vehicles/${shape["image"]}",
                      width: shape["size"],
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

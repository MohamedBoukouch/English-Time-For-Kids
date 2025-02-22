import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class Vehiclesview extends StatefulWidget {
  const Vehiclesview({super.key});

  @override
  _VehiclesviewState createState() => _VehiclesviewState();
}

class _VehiclesviewState extends State<Vehiclesview> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<Map<String, dynamic>> vehiclesList = [
    {"image": "aeroplane.png", "title": "Aeroplane", "size": 0.6},
    {"image": "ambulance.png", "title": "Ambulance", "size": 0.6},
    {"image": "bicycle.png", "title": "Bicycle", "size": 0.55},
    {"image": "boat.png", "title": "Boat", "size": 0.6},
    {"image": "bus.png", "title": "Bus", "size": 0.65},
    {"image": "car.png", "title": "Car", "size": 0.7},
    {"image": "helicopter.png", "title": "Helicopter", "size": 0.45},
    {"image": "motor_bike.png", "title": "Motor Bike", "size": 0.35},
    {"image": "parachute.png", "title": "Parachute", "size": 0.27},
    {"image": "police_car.png", "title": "Police Car", "size": 0.45},
    {"image": "school_bus.png", "title": "School Bus", "size": 0.55},
    {"image": "ship.png", "title": "Ship", "size": 0.6},
    {"image": "train.png", "title": "Train", "size": 0.47},
    {"image": "truck.png", "title": "Truck", "size": 0.6},
  ];

 

  @override
  void initState() {
    super.initState();
    _loadImage();
    _playSound(vehiclesList[_currentIndex]['title']);
  }

  void _loadImage() {
    setState(() => _isLoading = true);
    final imageProvider = AssetImage("assets/vehicles/${vehiclesList[_currentIndex]['image']}");
    imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((_, __) {
        setState(() => _isLoading = false);
      }),
    );
  }

  void _playSound(String title) {
    _audioPlayer.play(AssetSource('songs/vehicles/$title.m4a'));
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _loadImage();
        _playSound(vehiclesList[_currentIndex]['title']);
      });
    }
  }

  void _nextImage() {
    if (_currentIndex < vehiclesList.length - 1) {
      setState(() {
        _currentIndex++;
        _loadImage();
        _playSound(vehiclesList[_currentIndex]['title']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final shape = vehiclesList[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backVehicle.webp',
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
            child: GestureDetector(
              onTap: () => _playSound(shape["title"]),
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Boogaloo',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/vehicles/${shape["image"]}",
                            width: AppConstantes.screenWidth(context) * shape["size"],
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

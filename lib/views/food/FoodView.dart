import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  AudioPlayer _audioPlayer = AudioPlayer(); // Initialize the audio player
  int _currentIndex = 0;
  bool _isLoading = true; // Track loading state

  // Function to play the corresponding food song
  void _playFoodSong(String foodName) async {
    await _audioPlayer.stop();  // Stop any currently playing audio
    await _audioPlayer.play(AssetSource('songs/food/$foodName.m4a')); // Play the corresponding audio file
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // Initialize the shapesList inside the build method
    final List<Map<String, dynamic>> shapesList = [
      {"image": "burger.webp", "title": "Burger", "size": AppConstantes.screenWidth(context) * .33},
      {"image": "french-fry.webp", "title": "French Fry", "size": AppConstantes.screenWidth(context) * .33},
      {"image": "fried-chicken.webp", "title": "Fried Chicken", "size": AppConstantes.screenWidth(context) * .43},
      {"image": "hot-dog.webp", "title": "Hot Dog", "size": AppConstantes.screenWidth(context) * .33},
      {"image": "ice-cream.webp", "title": "Ice Cream", "size": AppConstantes.screenWidth(context) * .35},
      {"image": "milk.webp", "title": "Milk", "size": AppConstantes.screenWidth(context) * .17},
      {"image": "milkshake.webp", "title": "Milkshake", "size": AppConstantes.screenWidth(context) * .37},
      {"image": "noodles.webp", "title": "Noodles", "size": AppConstantes.screenWidth(context) * .5},
      {"image": "pizza.webp", "title": "Pizza", "size": AppConstantes.screenWidth(context) * .4},
      {"image": "popcorn.webp", "title": "Popcorn", "size": AppConstantes.screenWidth(context) * .22},
      {"image": "sandwich.webp", "title": "Sandwich", "size": AppConstantes.screenWidth(context) * .5},
    ];

    void _previousImage() {
      setState(() {
        if (_currentIndex > 0) {
          _currentIndex--;
          _playFoodSong(shapesList[_currentIndex]["title"].toLowerCase());  // Play previous food's song
        }
      });
    }

    void _nextImage() {
      setState(() {
        if (_currentIndex < shapesList.length - 1) {
          _currentIndex++;
          _playFoodSong(shapesList[_currentIndex]["title"].toLowerCase());  // Play next food's song
        }
      });
    }
      final shape = shapesList[_currentIndex];

    // Ensure the first song (burger) plays when the page loads
    if (_currentIndex == 0) {
      _playFoodSong(shapesList[_currentIndex]["title"].toLowerCase());
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/backgrounds/backShapes.webp',
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
                      child: GestureDetector(
                        onTap: () {
                          _playFoodSong(shape["title"].toLowerCase()); // Play the song again when image is tapped
                        },
                        child: Image.asset(
                          "assets/foods/${shape["image"]}",
                          width: shape["size"],
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (frame == null) {
                              return CircularProgressIndicator(); // Show loading indicator if image is not loaded yet
                            }
                            return child; // Return image once it's loaded
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(top: 3, bottom: 3, right: 50, left: 50),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
      ),
    );
  }
}

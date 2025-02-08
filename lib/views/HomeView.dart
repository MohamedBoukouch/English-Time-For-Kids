import 'package:english_for_kids/views/body-party/BodyParte.dart';
import 'package:english_for_kids/views/food/FoodView.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:english_for_kids/views/alphabets/AlphanetsView.dart';
import 'package:english_for_kids/views/colors/ColorsView.dart';
import 'package:english_for_kids/views/fruits/FruitsView.dart';
import 'package:english_for_kids/views/numbers/NumbersHome.dart';
import 'package:english_for_kids/views/seasons/SeasonView.dart';
import 'package:english_for_kids/views/shapes/ShapesView.dart';
import 'package:english_for_kids/views/vegetables/VegetablesView.dart';
import 'package:english_for_kids/views/week_days/WeekDaysView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  final AudioPlayer _audioPlayer = AudioPlayer();  // Audio player instance
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();  // Dispose audio player
    super.dispose();
  }

  Future<void> _playPopSound() async {
    await _audioPlayer.play(AssetSource('songs/pop.flac'));
  }

  void _navigateToPage(String title) async {
    await _playPopSound();  // Play sound before navigating

    Widget? destination;
    switch (title) {
      case 'Alphabets':
        destination = AlphanetsView();
        break;
      case 'Numbers':
        destination = NumbersHome();
        break;
      case 'Shapes':
        destination = Shapesview();
        break;
      case 'Colors':
        destination = ColorsView();
        break;
      case 'Vehicles':
        destination = VegetablesView();
        break;
      case 'Vegetables':
        destination = VegetablesView();
        break;
      case 'Fruits':
        destination = FruitsView();
        break;
      case 'Seasons':
        destination = SeasonView();
        break;
      case 'Week Days':
        destination = WeekDaysView();
        break;
      case 'Food':
        destination = FoodView();
        break;
      case 'Body Parts':
        destination = BodyParts();
        break;
      default:
        return;
    }

    if (destination != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {"title": "Alphabets", "image": "assets/categories/abc.jpg"},
      {"title": "Colors", "image": "assets/categories/123.png"},
      {"title": "Numbers", "image": "assets/categories/abc.jpg"},
      {"title": "Shapes", "image": "assets/categories/abc.jpg"},
      {"title": "Vehicles", "image": "assets/categories/abc.jpg"},
      {"title": "Vegetables", "image": "assets/categories/abc.jpg"},
      {"title": "Fruits", "image": "assets/categories/abc.jpg"},
      {"title": "Seasons", "image": "assets/categories/abc.jpg"},
      {"title": "Week Days", "image": "assets/categories/abc.jpg"},
      {"title": "Food", "image": "assets/categories/abc.jpg"},
      {"title": "Body Parts", "image": "assets/categories/abc.jpg"},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: categories.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  double scale = _currentPage == index ? 1.2 : 0.8;

                  return GestureDetector(
                    onTap: () => _navigateToPage(categories[index]['title']!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: _currentPage == index
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.7),
                                      blurRadius: 10,
                                      offset: Offset(0, 9),
                                    )
                                  ]
                                : [],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  categories[index]['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Center(
                                      child: Text(
                                        categories[index]['title']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

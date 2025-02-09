import 'package:english_for_kids/configs/constant.dart';
import 'package:english_for_kids/utils/AppFunction.dart';
import 'package:english_for_kids/views/body-party/BodyParte.dart';
import 'package:english_for_kids/views/food/FoodView.dart';
import 'package:english_for_kids/views/months/MonthsViews.dart';
import 'package:english_for_kids/views/settings/SettingsView.dart';
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
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentPage = 0;

  List<Map<String, String>> categories = [
    {"title": "Alphabets", "image": "assets/categories/abc.jpg", "audio": "alphabets.m4a"},
    {"title": "Numbers", "image": "assets/categories/123.jpg", "audio": "numbers.m4a"},
    {"title": "Colors", "image": "assets/categories/colors.jpg", "audio": "colors.m4a"},
    {"title": "Shapes", "image": "assets/categories/abc.jpg", "audio": "shapes.m4a"},
    {"title": "Vehicles", "image": "assets/categories/vehicles.jpg", "audio": "vehicles.m4a"},
    {"title": "Vegetables", "image": "assets/categories/vegetables.jpg", "audio": "vegetables.m4a"},
    {"title": "Fruits", "image": "assets/categories/fruits.jpg", "audio": "vegetables.m4a"},
    {"title": "Seasons", "image": "assets/categories/seasons.jpg", "audio": "seasons.m4a"},
    {"title": "Week Days", "image": "assets/categories/week_days.jpg", "audio": "week days.m4a"},
    {"title": "Months", "image": "assets/categories/abc.jpg", "audio": "months.m4a"},
    {"title": "Foods", "image": "assets/categories/foods.jpg", "audio": "foods.m4a"},
    {"title": "Body Parts", "image": "assets/categories/body_parts.jpg", "audio": "body parts.m4a"},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    int newIndex = _pageController.page!.round();
    if (newIndex != _currentPage) {
      setState(() {
        _currentPage = newIndex;
      });
      _playCategorySound(newIndex);
    }
  }

  Future<void> _playCategorySound(int index) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("songs/categories/${categories[index]["audio"]!}"));
  }

  void _navigateToPage(String title) async {
    await _playCategorySound(_currentPage); // Play sound before navigating

    Widget? destination;
    switch (title) {
      case 'Alphabets':
        destination = AlphabetsView();
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
        destination = VegetablesView(); // Check if this is correct
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
      case 'Foods':
        destination = FoodView();
        break;
      case 'Months':
        destination = Months();
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back/backHome.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Image.asset("assets/icons/logout.gif", width: AppConstantes.screenWidth(context) * .07),
              onPressed: () {
                SystemNavigator.pop();;
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset("assets/icons/start.gif", width: AppConstantes.screenWidth(context) * .07),
                  onPressed: () => AppFunctions.showRateDialog(context),
                ),
                IconButton(
                  icon: Image.asset("assets/icons/settings.gif", width: AppConstantes.screenWidth(context) * .07),
                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SettingsView()),
                                  ),
                ),
              ],
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
                                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Center(
                                      child: Text(
                                        categories[index]['title']!,
                                        style: const TextStyle(
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

import 'package:english_for_kids/ads/adsmanager.dart';
import 'package:english_for_kids/configs/constant.dart';
import 'package:english_for_kids/utils/AppFunction.dart';
import 'package:english_for_kids/views/body-party/BodyParte.dart';
import 'package:english_for_kids/views/food/FoodView.dart';
import 'package:english_for_kids/views/months/MonthsViews.dart';
import 'package:english_for_kids/views/settings/SettingsView.dart';
import 'package:english_for_kids/views/vehicles/VehiclesView.dart';
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
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  bool _isLoading = true;
  bool _isLoadingInterstitial = false;
  InterstitialAd? _interstitialAd;



  
  List<Map<String, String>> categories = [
    {"title": "Alphabets", "image": "assets/categories/abc.webp", "audio": "alphabets.m4a"},
    {"title": "Numbers", "image": "assets/categories/123.webp", "audio": "numbers.m4a"},
    {"title": "Colors", "image": "assets/categories/colors.webp", "audio": "colors.m4a"},
    {"title": "Shapes", "image": "assets/categories/shapes.webp", "audio": "shapes.m4a"},
    {"title": "Vehicles", "image": "assets/categories/vehicles.webp", "audio": "vehicles.m4a"},
    {"title": "Vegetables", "image": "assets/categories/vegetables.webp", "audio": "vegetables.m4a"},
    {"title": "Fruits", "image": "assets/categories/fruits.webp", "audio": "fruits.m4a"},
    {"title": "Seasons", "image": "assets/categories/seasons.webp", "audio": "seasons.m4a"},
    {"title": "Week Days", "image": "assets/categories/week_days.webp", "audio": "week days.m4a"},
    {"title": "Months", "image": "assets/categories/months.webp", "audio": "months.m4a"},
    {"title": "Foods", "image": "assets/categories/foods.webp", "audio": "foods.m4a"},
    {"title": "Body Parts", "image": "assets/categories/body_parts.webp", "audio": "body parts.m4a"},
  ];


  //ADS
  
  void _createInterstitialAd() {
    _isLoadingInterstitial = true;
    InterstitialAd.load(
      adUnitId: AdsManger.interstitialAdUnit!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
            _isLoadingInterstitial = false;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            _isLoadingInterstitial = false;
          });
        },
      ),
    );
  }
    void _showInterstitial() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      print("Interstitial Ad is null");
    }
  }
  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
    _createInterstitialAd();
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
    _showInterstitial();

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
        destination = Vehiclesview(); // Check if this is correct
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
              'assets/backgrounds/backHome.webp',
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
                              if (_isLoading)
                                Center(child: CircularProgressIndicator()),
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
                                        style:  TextStyle(
                                          fontSize: _currentPage==index?25:20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Boogaloo'
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

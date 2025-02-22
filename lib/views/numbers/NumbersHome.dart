import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:english_for_kids/ads/adsmanager.dart';
import 'package:english_for_kids/views/numbers/AdditionPage.dart';
import 'package:english_for_kids/views/numbers/DivisionPage.dart';
import 'package:english_for_kids/views/numbers/FindNumber.dart';
import 'package:english_for_kids/views/numbers/MultiplicationPage.dart';
import 'package:english_for_kids/views/numbers/NumberCount.dart';
import 'package:english_for_kids/views/numbers/SubtractionPage.dart';

class NumbersHome extends StatefulWidget {
  const NumbersHome({super.key});

  @override
  State<NumbersHome> createState() => _NumbersHomeState();
}

class _NumbersHomeState extends State<NumbersHome> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsManger.interstitialAdUnit!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => setState(() => _interstitialAd = ad),
        onAdFailedToLoad: (error) => setState(() => _interstitialAd = null),
      ),
    );
  }

  void _showInterstitial() {
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  final List<Map<String, dynamic>> _categories = [
    {"title": "Number Count", "image": "assets/numbers/count.webp", "page": NumberCount()},
    {"title": "Find Number", "image": "assets/numbers/find.webp", "page": FindNumber()},
    {"title": "Addition", "image": "assets/numbers/math.webp", "page": AdditionPage()},
    {"title": "Subtraction", "image": "assets/numbers/math.webp", "page": SubtractionPage()},
    {"title": "Division", "image": "assets/numbers/math.webp", "page": DivisionPage()},
    {"title": "Multiplication", "image": "assets/numbers/math.webp", "page": MultiplicationPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/numberCount.gif',
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _categories.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final double scale = _currentPage == index ? 1.2 : 0.8;

                  return GestureDetector(
                    onTap: () {
                      _showInterstitial();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => category['page']),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  category['image'],
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
                                  child: Padding(
                                    padding: _currentPage == index ? EdgeInsets.only(bottom: 10):EdgeInsets.only(bottom: 0),
                                    child: Center(
                                      child: Text(
                                        category['title'],
                                        style: TextStyle(
                                          fontSize: _currentPage == index ? 25 : 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Boogaloo',
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

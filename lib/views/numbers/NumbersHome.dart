import 'package:flutter/material.dart';
import 'package:english_for_kids/views/numbers/AdditionPage.dart';
import 'package:english_for_kids/views/numbers/DivisionPage.dart';
import 'package:english_for_kids/views/numbers/FindNumber.dart';
import 'package:english_for_kids/views/numbers/MultiplicationPage.dart';
import 'package:english_for_kids/views/numbers/NumberCount.dart';
import 'package:english_for_kids/views/numbers/SubtractionPage.dart';
import 'package:english_for_kids/configs/constant.dart';
import 'package:get/get.dart';

class NumbersHome extends StatefulWidget {
  const NumbersHome({super.key});

  @override
  State<NumbersHome> createState() => _NumbersHomeState();
}

class _NumbersHomeState extends State<NumbersHome> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;
  bool _isLoading = true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {"title": "Number Count", "image": "assets/numbers/count.jpg"},
      {"title": "Find Number", "image": "assets/numbers/find.png"},
      {"title": "Addition", "image": "assets/numbers/find.png"},
      {"title": "Subtraction", "image": "assets/numbers/find.png"},
      {"title": "Division", "image": "assets/numbers/find.png"},
      {"title": "Multiplication", "image": "assets/numbers/find.png"},
    ];

    double screenWidth = AppConstantes.screenWidth(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/numberCount.gif',
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Category Slider
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 180, // Adjust height as needed
              child: PageView.builder(
                controller: _pageController,
                itemCount: categories.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  double scale = _currentPage == index ? 1.2 : 0.8; // Scale effect

                  return GestureDetector(
                    onTap: () {
                      if (categories[index]['title'] == 'Number Count') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NumberCount()),
                        );
                      } else if (categories[index]['title'] == 'Find Number') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindNumber()),
                        );
                      } else if (categories[index]['title'] == 'Addition') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdditionPage()),
                        );
                      } else if (categories[index]['title'] == 'Subtraction') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SubtractionPage()),
                        );
                      } else if (categories[index]['title'] == 'Division') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DivisionPage()),
                        );
                      } else if (categories[index]['title'] == 'Multiplication') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MultiplicationPage()),
                        );
                      } else {
                        null;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.scale(
                        scale: scale, // Apply scale effect
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  categories[index]['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150, // Adjust as needed
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                categories[index]['title']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: _currentPage == index ? 18 : 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Boogaloo',
                                  color: _currentPage == index
                                      ? Colors.black
                                      : Colors.grey[700],
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

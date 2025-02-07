import 'package:english_for_kids/views/alphabets/AlphanetsView.dart';
import 'package:english_for_kids/views/colors/ColorsView.dart';
import 'package:english_for_kids/views/fruits/FruitsView.dart';
import 'package:english_for_kids/views/numbers/NumbersHome.dart';
import 'package:english_for_kids/views/seasons/SeasonView.dart';
import 'package:english_for_kids/views/shapes/ShapesView.dart';
import 'package:english_for_kids/views/vegetables/VegetablesView.dart';
import 'package:english_for_kids/views/vehicles/VehiclesView.dart';
import 'package:english_for_kids/views/week_days/WeekDaysView.dart';
import 'package:flutter/material.dart';
import 'package:english_for_kids/configs/constant.dart';
import 'package:get/get.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {"title": "Alphabets", "image": "assets/categories/abc.jpg"},
      {"title": "Colors", "image": "assets/categories/123.webp"},
      {"title": "Numbers", "image": "assets/categories/abc.jpg"},
      {"title": "Shapes", "image": "assets/categories/abc.jpg"},
      {"title": "Vehicles", "image": "assets/categories/abc.jpg"},
      {"title": "Vegetables", "image": "assets/categories/abc.jpg"},
      {"title": "Fruits", "image": "assets/categories/abc.jpg"},
      {"title": "Foods", "image": "assets/categories/abc.jpg"},
      {"title": "Seasons", "image": "assets/categories/abc.jpg"},
      {"title": "Week Days", "image": "assets/categories/abc.jpg"},
      {"title": "Birds", "image": "assets/categories/abc.jpg"},
      {"title": "Animals", "image": "assets/categories/abc.jpg"},
      {"title": "Body Parts", "image": "assets/categories/abc.jpg"},
      {"title": "Months", "image": "assets/categories/abc.jpg"},
    ];

    double screenWidth = AppConstantes.screenWidth(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/back.jpg',
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
                      if(categories[index]['title']=='Alphabets'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AlphanetsView()),
                        );
                      }else if(categories[index]['title']=='Numbers'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NumbersHome()),
                      );
                      }else if(categories[index]['title']=='Shapes'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Shapesview()),
                      );
                      }else if(categories[index]['title']=='Colors'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ColorsView()),
                      );
                      }else if(categories[index]['title']=='Vehicles'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Vehiclesview()),
                      );
                      }else if(categories[index]['title']=='Vegetables'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VegetablesView()),
                      );
                      }else if(categories[index]['title']=='Fruits'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FruitsView()),
                      );
                      }else if(categories[index]['title']=='Seasons'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeasonView()),
                      );
                      }else if(categories[index]['title']=='Week Days'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeekDaysView()),
                      );
                      }else{
                        null;
                      }

                    },
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Transform.scale(
                        scale: scale, // Apply scale effect
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
                              // Background Image
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
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 9),
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

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class Months extends StatefulWidget {
  const Months({super.key});

  @override
  _MonthsState createState() => _MonthsState();
}

class _MonthsState extends State<Months> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> monthsList = [
    {"title": "January", "color": Colors.red},
    {"title": "February", "color": Colors.blue},
    {"title": "March", "color": Colors.yellow},
    {"title": "April", "color": Colors.green},
    {"title": "May", "color": Colors.pink},
    {"title": "June", "color": Colors.orange},
    {"title": "July", "color": Colors.purple},
    {"title": "August", "color": Colors.brown},
    {"title": "September", "color": Colors.lightBlue},
    {"title": "October", "color": Colors.redAccent},
    {"title": "November", "color": Colors.pinkAccent},
    {"title": "December", "color": Colors.blueGrey},
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _playAudio(monthsList[_currentIndex]["title"]); // Play first month on load
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String month) async {
    String audioPath = "songs/months/${month.toLowerCase()}.m4a";
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(audioPath));
  }

  void _nextMonth() {
    setState(() {
      if (_currentIndex < monthsList.length - 1) {
        _currentIndex++;
        _playAudio(monthsList[_currentIndex]["title"]);
      }
    });
  }

  void _previousMonth() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playAudio(monthsList[_currentIndex]["title"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final month = monthsList[_currentIndex];

    return Scaffold(
      body: Stack(
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
            child: GestureDetector(
              onTap: () => _playAudio(month["title"]), // Replay audio on tap
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/colors/color_forme.png",
                    width: AppConstantes.screenWidth(context) * .60,
                    color: month["color"],
                  ),
                  Text(
                    month["title"],
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Boogaloo',
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
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
              onPressed: _previousMonth,
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
              onPressed: _nextMonth,
            ),
          ),
        ],
      ),
    );
  }
}

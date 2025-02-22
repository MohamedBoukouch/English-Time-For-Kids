import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class WeekDaysView extends StatefulWidget {
  const WeekDaysView({super.key});

  @override
  _WeekDaysViewState createState() => _WeekDaysViewState();
}

class _WeekDaysViewState extends State<WeekDaysView> {
  final List<Map<String, dynamic>> colorsList = [
    {"title": "Monday", "color": Colors.red, "song": "songs/days/Monday.m4a"},
    {"title": "Tuesday", "color": Colors.blue, "song": "songs/days/Tuesday.m4a"},
    {"title": "Wednesday", "color": Colors.yellow, "song": "songs/days/Wednesday.m4a"},
    {"title": "Thursday", "color": Colors.green, "song": "songs/days/Thursday.m4a"},
    {"title": "Friday", "color": Colors.pink, "song": "songs/days/Friday.m4a"},
    {"title": "Saturday", "color": Colors.orange, "song": "songs/days/Saturday.m4a"},
    {"title": "Sunday", "color": Colors.purple, "song": "songs/days/Sunday.m4a"},
  ];

  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playCurrentSong(); // Play the first day's song on startup
  }

  void _playCurrentSong() async {
    String songPath = colorsList[_currentIndex]["song"];
    await _audioPlayer.stop(); // Stop any playing song
    await _audioPlayer.play(AssetSource(songPath)); // Play new song
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < colorsList.length - 1) {
        _currentIndex++;
        _playCurrentSong();
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playCurrentSong();
      }
    });
  }

  void _onImageTap() {
    _playCurrentSong(); // Play song when clicking on the image
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of audio player to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shape = colorsList[_currentIndex];

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
              onTap: _onImageTap, // Play song on image tap
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/colors/color_forme.png",
                    width: AppConstantes.screenWidth(context) * .60,
                    color: shape["color"],
                  ),
                  Text(
                    shape["title"],
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

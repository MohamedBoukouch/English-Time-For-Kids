import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../configs/constant.dart';

class SeasonView extends StatefulWidget {
  const SeasonView({super.key});

  @override
  _SeasonViewState createState() => _SeasonViewState();
}

class _SeasonViewState extends State<SeasonView> {
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> _seasonsList = [
    {"image": "spring.avif", "title": "Spring", "color": Colors.green, "size": .31, "audio": "Spring.m4a"},
    {"image": "summer.jpg", "title": "Summer", "color": Colors.yellow, "size": .31, "audio": "Summer.m4a"},
    {"image": "winter.jpg", "title": "Winter", "color": Colors.blue, "size": .34, "audio": "Winter.m4a"},
    {"image": "autumn.avif", "title": "Autumn", "color": Colors.brown, "size": .31, "audio": "Autumn.m4a"},
  ];

  @override
  void initState() {
    super.initState();
    _playSeasonAudio(); // Jouer le son du premier élément au démarrage
  }

  void _playSeasonAudio() async {
    String audioPath = "songs/seasons/${_seasonsList[_currentIndex]['audio']}";
    await _audioPlayer.stop(); // Arrêter l'ancien son avant de jouer le nouveau
    await _audioPlayer.play(AssetSource(audioPath));
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playSeasonAudio(); // Lire le son après changement
      }
    });
  }

  void _nextImage() {
    setState(() {
      if (_currentIndex < _seasonsList.length - 1) {
        _currentIndex++;
        _playSeasonAudio(); // Lire le son après changement
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Nettoyage du lecteur audio
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final season = _seasonsList[_currentIndex];

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _playSeasonAudio, // Lecture audio au clic sur l'image
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 88, 85, 85),
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/seasons/${season["image"]}",
                      width: AppConstantes.screenWidth(context) * season["size"],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  season["title"],
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: season["color"],
                    fontFamily: 'Boogaloo',
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30,
            child: IconButton(
              icon: Image.asset("assets/icons/back.png", width: AppConstantes.screenWidth(context) * .1),
              onPressed: _previousImage,
            ),
          ),

          Positioned(
            right: 30,
            top: AppConstantes.screenHeight(context) / 2 - 30,
            child: IconButton(
              icon: Image.asset("assets/icons/next.png", width: AppConstantes.screenWidth(context) * .1),
              onPressed: _nextImage,
            ),
          ),
        ],
      ),
    );
  }
}

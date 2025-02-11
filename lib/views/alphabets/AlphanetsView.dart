import 'package:english_for_kids/configs/constant.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetsView extends StatefulWidget {
  const AlphabetsView({super.key});

  @override
  _AlphabetsViewState createState() => _AlphabetsViewState();
}

class _AlphabetsViewState extends State<AlphabetsView> {
  final List<String> alphabetList = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  ];

  final List<Color> alphabetColors = [
    Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple,
    Colors.pink, Colors.teal, Colors.cyan, Colors.lime, Colors.indigo,
    Colors.amber, Colors.brown, Colors.deepOrange, Colors.deepPurple,
    Colors.lightBlue, Colors.lightGreen, Colors.yellow, Colors.grey,
    Colors.blueGrey, Colors.redAccent, Colors.blueAccent, Colors.greenAccent,
    Colors.orangeAccent, Colors.purpleAccent, Colors.pinkAccent, Colors.tealAccent
  ];

  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Instance du lecteur audio

  @override
  void initState() {
    super.initState();
    _playSound(); // Jouer le son du premier caractère au chargement
  }

  // Fonction pour jouer le son de l'alphabet actuel
  Future<void> _playSound() async {
    String soundPath = "songs/alphabets/${alphabetList[_currentIndex]}.m4a";
    await _audioPlayer.stop(); // Arrêter le son précédent
    await _audioPlayer.play(AssetSource(soundPath));
  }

  // Passer à l'alphabet suivant
  void _nextImage() {
    setState(() {
      if (_currentIndex < alphabetList.length - 1) {
        _currentIndex++;
        _playSound(); // Jouer le son de la nouvelle lettre
      }
    });
  }

  // Revenir à l'alphabet précédent
  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _playSound(); // Jouer le son de la nouvelle lettre
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Libérer les ressources du lecteur audio
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/backShapes.jpg',
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

          // Affichage de l'alphabet
          Center(
            child: GestureDetector(
              onTap: _playSound, // Rejouer le son en cliquant sur la lettre
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  alphabetList[_currentIndex],
                  style: TextStyle(
                    color: alphabetColors[_currentIndex], // Couleur différente pour chaque lettre
                    fontWeight: FontWeight.w600,
                    fontSize: 280,
                    fontFamily: 'Boogaloo',
                  ),
                ),
              ),
            ),
          ),

          // Bouton "Précédent"
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

          // Bouton "Suivant"
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

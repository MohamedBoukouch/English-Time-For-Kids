import 'package:english_for_kids/configs/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Function to open the Play Store
  void _openPlayStore() async {
    const url = "https://play.google.com/store/apps/details?id=com.yourpackage.name"; // Replace with your app package name
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open Play Store");
    }
  }

  // Function to contact the developer (e.g., via email)
  void _contactDeveloper() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'developer@example.com', // Replace with your actual email
      queryParameters: {
        'subject': 'Support Inquiry',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("Could not open email");
    }
  }

  // Function to show the Rate Us dialog
  void _showRateDialog() {
    Alert(
      context: context,
      type: AlertType.none,
      title: "Show Love ❤",
      desc: "If our content brightens your child's day, please support us with a 5-star rating. Thank You!",
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        descStyle: TextStyle(fontSize: 16),
      ),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(Icons.star, color: Colors.amber, size: 30);
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: _openPlayStore,
          color: Colors.blue,
          child: Text(
            "Rate Now",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back/backSettings.jpg',
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
           Positioned(
            top: 40,
            right: AppConstantes.screenWidth(context)*.45,
            child: Text("Settings",
            style: TextStyle(
              fontFamily: 'Boogaloo',
              fontSize: 35,
              fontWeight: FontWeight.w400
            ),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(Icons.apps, "More Apps", () {
                  _openPlayStore(); // Replace with your more apps URL
                }),
                const SizedBox(height: 15),
                _buildButton(Icons.email, "Contact Developer", _contactDeveloper),
                const SizedBox(height: 15),
                _buildButton(Icons.star, "Rate Us", _showRateDialog),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, VoidCallback onPressed) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.white), // Icon on the left
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
          ],
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {


static void showRateDialog(BuildContext context) {
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
        // 5 Golden Stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Icon(
              Icons.star,
              color: Colors.amber, // Golden color
              size: 30,
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    ),
    buttons: [
      DialogButton(
        onPressed: () => _openPlayStore(),
        color: Colors.blue, // Button color
        child: Text(
          "Rate Now",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ],
  ).show();
}


static void _openPlayStore() async {
  const url = "https://play.google.com/store/apps/details?id=com.yourpackage.name"; // Replace with your actual package name
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Could not open Play Store");
  }
}

}
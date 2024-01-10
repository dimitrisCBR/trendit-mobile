import 'package:flutter/material.dart';

class TrenditRoundLogo extends StatelessWidget {
  const TrenditRoundLogo({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color tint;
    if (isDarkMode) {
      tint = Colors.white; // Choose a color for dark mode
    } else {
      tint = Colors.black; // Choose a color for light mode
    }
    return Center(
        child: Container(
            width: 150, // Adjust size as needed
            height: 150, // Adjust size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onPrimary, // Change the circle color here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                  child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  tint, // Tint color
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/images/trendit_icon.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )),
            )));
  }
}

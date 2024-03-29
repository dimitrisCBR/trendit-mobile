import 'package:flutter/material.dart';
import 'package:trendit/src/ui/styles/text_styles.dart';

class TrenditBannerWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const TrenditBannerWidget(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: googleFontStyle(Theme.of(context).textTheme.headlineLarge),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            style: googleFontStyle(Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}

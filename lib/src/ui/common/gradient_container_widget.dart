import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget? child;

  const GradientContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.primaryColor,
            theme.primaryColorDark,
          ],
        ),
      ),
      child: child,
    );
  }
}

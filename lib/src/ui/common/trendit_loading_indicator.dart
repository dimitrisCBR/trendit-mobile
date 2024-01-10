import 'package:flutter/material.dart';

class TrenditLoadingIndicator extends StatelessWidget {
  final double size;

  const TrenditLoadingIndicator(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }

}
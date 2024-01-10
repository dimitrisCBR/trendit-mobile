import 'package:flutter/material.dart';

class ChipRowWidget extends StatelessWidget {
  final List<String> chipText;

  const ChipRowWidget({super.key, required this.chipText});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: chipText.map((String text) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Chip(
              labelPadding: const EdgeInsets.all(2),
              label: Text(
                text,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              )),
        );
      }).toList(),
    );
  }
}

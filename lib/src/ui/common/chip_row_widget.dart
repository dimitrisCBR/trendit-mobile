import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChipRowWidget extends StatelessWidget {
  final List<String> chipText;

  ChipRowWidget({required this.chipText});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: chipText.map((String text) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Chip(
              labelPadding: EdgeInsets.all(2),
              label: Text(
                text,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )),
        );
      }).toList(),
    );
  }
}

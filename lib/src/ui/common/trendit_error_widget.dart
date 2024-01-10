import 'package:flutter/material.dart';

class TrenditErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Function callback;

  const TrenditErrorWidget({super.key, required this.errorMessage, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
          child: Column(
            children: [
              const Text(
                "Server error",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform login action
                  callback();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

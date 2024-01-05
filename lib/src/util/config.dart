import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppConfig {
  static late final String baseUrl;

  static Future<void> loadConfig() async {
    try {
      final configString = await rootBundle.loadString('assets/secrets_config.json');
      final configJSON = json.decode(configString) as Map<String, dynamic>;
      baseUrl = configJSON['base_url'] ?? '';
    } catch (e) {
      print('Error loading configuration: $e');
      // TODO handle errors
    }
  }
}
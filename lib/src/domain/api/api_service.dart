import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trendit/src/domain/api/api_exception.dart';
import 'package:trendit/src/domain/api/auth_request.dart';
import 'package:trendit/src/util/config.dart';

class APIService {
  static final APIService instance = APIService._internal();
  late final String baseURL;

  APIService._internal() {
    baseURL = AppConfig.baseUrl; // Initialize baseURL from AppConfig
  }

  Future<String> login(AuthRequest request) async {
    final Uri url = Uri.parse('$baseURL/auth/login');
    final Map<String, dynamic> body = {'email': request.email, 'password': request.password};

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String token = jsonResponse['token'] as String;
        return token;
      } else {
        // Handle errors or non-200 status codes
        throw APIException("Error during login with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw APIException("Error during login: ${e}");
    }
  }

  Future<void> register(AuthRequest request) async {
    final Uri url = Uri.parse('$baseURL/auth/login');
    final Map<String, dynamic> body = {'email': request.email, 'password': request.password};

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
      } else {
        // Handle errors or non-200 status codes
        throw APIException("Error during login with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw APIException("Error during login: ${e}");
    }
  }
}

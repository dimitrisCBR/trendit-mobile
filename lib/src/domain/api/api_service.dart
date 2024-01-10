import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trendit/src/domain/api/api_exception.dart';
import 'package:trendit/src/domain/model/auth_request.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/settings/prefs.dart';
import 'package:trendit/src/util/config.dart';

class APIService {
  static final APIService instance = APIService._internal();
  late final String baseURL;

  APIService._internal() {
    baseURL = AppConfig.baseUrl;
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
      throw APIException("Error during login: $e");
    }
  }

  Future<String> register(AuthRequest request) async {
    final Uri url = Uri.parse('$baseURL/auth/register');
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
      throw APIException("Error during login: $e");
    }
  }

  Future<Trends> fetchTrends() async {
    final Uri url = Uri.parse('$baseURL/trends/latest');

    try {
      final String? jwt = await StorageHelper.getString(SETTINGS_TOKEN);
      if (jwt == null || jwt.isEmpty) {
        throw APIException("Unable to authenticate with server");
      }
      final Map<String, String> headers = {
        'Authorization': 'Bearer $jwt',
        // Add other headers as needed
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

        final googleTrendsJson = responseData[TrendKey.google.value].toList();
        final List<GoogleTrend> googleTrends = googleTrendsJson
            .map<GoogleTrend>((trendJson) => GoogleTrend.fromJson(trendJson))
            .toList();

        final twitterTrendsJson = responseData[TrendKey.twitter.value].toList();
        final List<TwitterTrend> twitterTrends = twitterTrendsJson.map<TwitterTrend>((trendJson) {
          print(trendJson);
          return TwitterTrend.fromJson(trendJson);
        }).toList();

        final youtubeTrendsJson = responseData[TrendKey.youtube.value].toList();
        final List<YoutubeTrend> youtubeTrends = youtubeTrendsJson
            .map<YoutubeTrend>((trendJson) => YoutubeTrend.fromJson(trendJson))
            .toList();

        return Future.value(Trends(
            TrendStore(TrendKey.google, googleTrends),
            TrendStore(TrendKey.twitter, twitterTrends),
            TrendStore(TrendKey.youtube, youtubeTrends)));
      } else {
        throw APIException("Error during fetching trends with status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw APIException("Error during fetching trends: $e");
    }
  }
}

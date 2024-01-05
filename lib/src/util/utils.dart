import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

sendEmail() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final Uri uri = Uri(
      scheme: 'mailto',
      path: 'kanellis@imperius.gr',
      queryParameters: {'subject': 'TrendIt App Feedback, v${packageInfo.version}'});

  var canLaunchLink = await canLaunchUrl(uri);
  debugPrint('can launch: $canLaunchLink');

  if (canLaunchLink) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

void launchURL(String _url) async {
  try {
    var uri = Uri.parse(_url);
    var canLaunchLink = await canLaunchUrl(uri);
    debugPrint('can launch: $canLaunchLink from $_url');
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } catch (_, __) {
    debugPrint('failure: $_ , $__');
  }
}

Future<String> loadPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var _versionInfo = "v.${packageInfo.version}";
  if (kReleaseMode) {
    _versionInfo = _versionInfo + "R";
  } else {
    _versionInfo = _versionInfo + "D";
  }
  return Future.value(_versionInfo);
}

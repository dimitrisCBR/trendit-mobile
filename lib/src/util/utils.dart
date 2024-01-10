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

void launchURL(String url) async {
  try {
    var uri = Uri.parse(url);
    var canLaunchLink = await canLaunchUrl(uri);
    debugPrint('can launch: $canLaunchLink from $url');
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } catch (_, __) {
    debugPrint('failure: $_ , $__');
  }
}

Future<String> loadPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var versionInfo = "v.${packageInfo.version}";
  if (kReleaseMode) {
    versionInfo = "${versionInfo}R";
  } else {
    versionInfo = "${versionInfo}D";
  }
  return Future.value(versionInfo);
}

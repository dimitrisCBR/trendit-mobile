import 'package:flutter/material.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/common/trendit_banner_widget.dart';
import 'package:trendit/src/ui/settings/prefs.dart';
import 'package:trendit/src/ui/splash_screen_widget.dart';
import 'package:trendit/src/ui/styles/text_styles.dart';
import 'package:trendit/src/util/utils.dart';

const URL_PRIVACY_TERMS = "https://gist.github.com/dimitrisCBR/e1da1b08acf9359686d01226ac021e96";

enum SettingsFrequency {
  often,
  rarely,
  minimum,
}

extension SettingsFrequencyCodes on SettingsFrequency {
  int getApiCode() {
    switch (this) {
      case SettingsFrequency.often:
        return 1;
      case SettingsFrequency.rarely:
        return 2;
      case SettingsFrequency.minimum:
        return 3;
    }
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsFrequency selectedFrequency = SettingsFrequency.often;

  var versionInfo = "";
  var email;

  @override
  void initState() {
    super.initState();
    _loadUI();
  }

  void _loadUI() async {
    email = StorageHelper.getString(SETTINGS_EMAIL);
    String? selection = StorageHelper.getString(SETTINGS_KEY);
    if (selection != null) {
      setState(() {
        selectedFrequency =
            SettingsFrequency.values.firstWhere((element) => element.toString() == selection);
      });
      _tryUploadFrequency(selectedFrequency);
    } else {
      saveSharedPref(SettingsFrequency.often);
    }
    var versionInfo = await loadPackageInfo();
    setState(() {
      versionInfo = versionInfo;
    });
  }

  void saveSharedPref(SettingsFrequency selection) async {
    await StorageHelper.saveString(SETTINGS_KEY, selection.toString());
    await StorageHelper.saveBool(SETTINGS_SET_KEY, true);
    setState(() {
      selectedFrequency = selection;
    });
    _tryUploadFrequency(selection);
  }

  void _tryUploadFrequency(SettingsFrequency frequency) async {
    var pendingUpload = StorageHelper.getBool(SETTINGS_SET_KEY) ?? false;
    if (email != null && email.isNotEmpty && pendingUpload) {
      //this flag means the frequency has been updated
      // TODO upload freq
      // await TrendItNetworkService.service
      //     .updateNotificationFrequency(UpdateFrequencyBody(email, frequency.getApiCode()))
      //     .then((value) {
      //   StorageHelper.saveBool(SETTINGS_SET_KEY, false);
      //   debugPrint("Trendit API: updated frequency id: ${frequency.getApiCode()}");
      // }).onError((error, stackTrace) {
      //   debugPrintStack(stackTrace: stackTrace);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      TrenditBannerWidget("Settings", versionInfo),
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Text(
            'How often would you like to receive updates?',
            style: googleFontStyle(Theme.of(context).textTheme.titleLarge),
          )),
      RadioListTile<SettingsFrequency>(
        title: Text(
          'Often, I want to stay informed',
          style: googleFontStyle(Theme.of(context).textTheme.labelMedium),
        ),
        value: SettingsFrequency.often,
        groupValue: selectedFrequency,
        onChanged: (SettingsFrequency? value) {
          if (value != null) {
            saveSharedPref(value);
          }
        },
      ),
      RadioListTile<SettingsFrequency>(
        title: Text(
          'A couple of times a day',
          style: googleFontStyle(Theme.of(context).textTheme.labelMedium),
        ),
        value: SettingsFrequency.rarely,
        groupValue: selectedFrequency,
        onChanged: (SettingsFrequency? value) {
          if (value != null) {
            saveSharedPref(value);
          }
        },
      ),
      RadioListTile<SettingsFrequency>(
        title: Text(
          'Only for breaking updates',
          style: googleFontStyle(Theme.of(context).textTheme.labelMedium),
        ),
        value: SettingsFrequency.minimum,
        groupValue: selectedFrequency,
        onChanged: (SettingsFrequency? value) {
          if (value != null) {
            saveSharedPref(value);
          }
        },
      ),
      const SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {
          sendEmail();
        },
        child: const Text('Contact Us'),
      ),
      const SizedBox(height: 8.0),
      ElevatedButton(
        onPressed: () {
          launchURL(URL_PRIVACY_TERMS);
        },
        child: const Text('Privacy policy'),
      ),
      const SizedBox(height: 8.0),
      ElevatedButton(
        onPressed: () {
          StorageHelper.remove(SETTINGS_EMAIL);
          StorageHelper.remove(SETTINGS_TOKEN);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SplashScreen()),
          );
        },
        child: const Text('Logout'),
      ),
      const SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
        onPressed: () {

          StorageHelper.remove(SETTINGS_EMAIL);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SplashScreen()),
          );
        },
        child: const Text('Delete account'),
      )
    ]));
  }
}

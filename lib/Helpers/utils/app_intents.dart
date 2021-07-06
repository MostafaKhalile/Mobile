import 'package:url_launcher/url_launcher.dart';
import 'package:platform/platform.dart';
import 'package:android_intent/android_intent.dart';

class VisitApp {
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void callApp(String url, String package) {
    print(url);
    if (const LocalPlatform().isAndroid) {
      final AndroidIntent intent = AndroidIntent(
          action: 'action_view', data: Uri.encodeFull(url), package: package);
      intent.launch();
    } else {
      launchURL(url);
    }
  }
}

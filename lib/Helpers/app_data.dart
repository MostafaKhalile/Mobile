import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static PackageInfo _packageInfo;

  static Future<void> init() async {
    if (_packageInfo == null) {
      _packageInfo = await PackageInfo.fromPlatform();
    }

    // print(
    //     "Application Info Here ==> $packageName $appName $version $buildNumber");
    return _packageInfo;
  }

  static String get appName => _packageInfo.appName;
  static String get packageName => _packageInfo.packageName;
  static String get version => _packageInfo.version;
  static String get buildNumber => _packageInfo.buildNumber;
}

import 'package:package_info_plus/package_info_plus.dart';

// ignore: avoid_classes_with_only_static_members
class AppInfo {
  static PackageInfo? _packageInfo;

  static Future<PackageInfo> init() async {
    return _packageInfo ??= await PackageInfo.fromPlatform();
  }

  static String get appName => _packageInfo!.appName;
  static String get packageName => _packageInfo!.packageName;
  static String get version => _packageInfo!.version;
  static String get buildNumber => _packageInfo!.buildNumber;
}

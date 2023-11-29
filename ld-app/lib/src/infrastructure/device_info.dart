import 'dart:io' show Platform;

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceInfo {
  DeviceInfoPlugin deviceInfo;
  AndroidId androidId;
  DeviceInfo(this.deviceInfo, this.androidId);
  Future<String> get deviceId async {
    if (Platform.isAndroid) {
      return await androidId.getId() ?? '';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return '';
  }
}

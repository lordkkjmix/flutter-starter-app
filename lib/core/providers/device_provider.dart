import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class DeviceProvider {
  Future<Map<String, String?>> get getPackageInfos;
  Future<Map<String, String?>> get getDeviceInfos;
  Future<DeviceModel> get device;
}

class DeviceProviderImpl implements DeviceProvider {
  Future<Map<String, String?>> get getPackageInfos async {
    final deviceInfoPlugin = Platform.isIOS
        ? await sl<DeviceInfoPlugin>().iosInfo
        : await sl<DeviceInfoPlugin>().androidInfo;
    final String? androidId = await sl<AndroidId>().getId();
    return {
      "brand": Platform.isIOS
          ? (deviceInfoPlugin as IosDeviceInfo).model
          : (deviceInfoPlugin as AndroidDeviceInfo).brand,
      "model": Platform.isIOS
          ? (deviceInfoPlugin as IosDeviceInfo).utsname.machine.toString()
          : (deviceInfoPlugin as AndroidDeviceInfo).model,
      "deviceUniqueIdentifier": Platform.isIOS
          ? (deviceInfoPlugin as IosDeviceInfo).identifierForVendor
          : androidId ??
              "${(deviceInfoPlugin as AndroidDeviceInfo).device}_${(deviceInfoPlugin as AndroidDeviceInfo).id}",
      "systemVersion": Platform.isIOS
          ? (deviceInfoPlugin as IosDeviceInfo).systemVersion
          : (deviceInfoPlugin as AndroidDeviceInfo).version.baseOS
    };
  }

  Future<Map<String, String?>> get getDeviceInfos async {
    final PackageInfo packageInfoPlugin = await PackageInfo.fromPlatform();
    return {
      "appVersion": packageInfoPlugin.version,
      "appBuildNumber": packageInfoPlugin.buildNumber,
      "appPackageName": packageInfoPlugin.packageName,
      "installerStore": packageInfoPlugin
          .installerStore, //useful to track intallation origin(optional because analytics can do this job)
      "buildSignature": packageInfoPlugin
          .buildSignature, //useful to prevent reverse engineering build
    };
  }

  Future<DeviceModel> get device async {
    final deviceInfo = await getPackageInfos;
    final packageInfo = await getDeviceInfos;
    deviceInfo.addAll(packageInfo);
    return DeviceModel.fromJson(deviceInfo);
  }
}

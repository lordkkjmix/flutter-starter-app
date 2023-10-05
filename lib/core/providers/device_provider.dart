import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:flutter_starter_app/core/providers/localization_provider.dart';
import 'package:flutter_starter_app/features/main/data/models/device_model.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class DeviceProvider {
  Future<Map<String, String?>> get getPackageInfos;
  Future<Map<String, String?>> get getDeviceInfos;
  Future<DeviceModel> get device;
}

class DeviceProviderImpl implements DeviceProvider {
  @override
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
      "deviceUniqueIdentifier": Platform.isIOS //userful to banned a device
          ? (deviceInfoPlugin as IosDeviceInfo).identifierForVendor
          : androidId ??
              "${(deviceInfoPlugin as AndroidDeviceInfo).device}_${(deviceInfoPlugin).id}",
      "systemVersion": Platform.isIOS
          ? (deviceInfoPlugin as IosDeviceInfo).systemVersion
          : (deviceInfoPlugin as AndroidDeviceInfo).version.baseOS
    };
  }

  @override
  Future<Map<String, String?>> get getDeviceInfos async {
    final PackageInfo packageInfoPlugin = await PackageInfo.fromPlatform();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    return {
      "appVersion": packageInfoPlugin.version,
      "appBuildNumber": packageInfoPlugin.buildNumber,
      "appIdentifier": packageInfoPlugin.packageName,
      "installerStore": packageInfoPlugin
          .installerStore, //useful to track installation origin(optional because analytics can do this job)
      "buildSignature": packageInfoPlugin
          .buildSignature, //useful to prevent reverse engineering build
      "timeZone": currentTimeZone,
      "deviceToken": "from Firebase or Huawei",
      "deviceType": Platform.operatingSystem,
      "installationId": "", //Useful to track installation from your api
      "deviceLocale": LocalizationProvider.currentLocale.languageCode,
    };
  }

  @override
  Future<DeviceModel> get device async {
    final deviceInfo = await getPackageInfos;
    final packageInfo = await getDeviceInfos;
    deviceInfo.addAll(packageInfo);
    return DeviceModel.fromJson(deviceInfo);
  }
}

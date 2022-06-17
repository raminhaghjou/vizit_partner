import 'dart:convert';
import 'dart:io';

import 'package:vizitland_partner/models/currencyModel.dart';
import 'package:vizitland_partner/models/partnerUserModel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

String appName = 'Secure Wallet';

String appVersion = '1.0';
String appDeviceId;
SharedPreferences sp;
Currency currency = new Currency();
CurrentUser user = new CurrentUser();
// String baseUrl = 'https://thecodecafe.in/gofresha/api/partner/';
String baseUrl = 'https://salon.vizitland.com/api/partner/';
//  String baseUrlForImage = 'https://thecodecafe.in/gofresha/';
String baseUrlForImage = 'https://salon.vizitland.com/';
List<String> rtlLanguageCodeLList = [
  'ar',
  'arc',
  'ckb',
  'dv',
  'fa',
  'ha',
  'he',
  'khw',
  'ks',
  'ps',
  'ur',
  'uz_AF',
  'yi'
];
String languageCode;

bool isRTL = false;
Future<Map<String, String>> getApiHeaders(bool authorizationRequired) async {
  Map<String, String> apiHeader = new Map<String, String>();
  if (authorizationRequired) {
    sp = await SharedPreferences.getInstance();
    if (sp.getString("currentUser") != null) {
      CurrentUser currentUser =
          CurrentUser.fromJson(json.decode(sp.getString("currentUser")));
    }
  }
  apiHeader.addAll({"Content-Type": "application/json"});
  apiHeader.addAll({"Accept": "application/json"});
  //apiHeader.addAll({"Content-Type": "application/x-www-form-urlencoded"});
  return apiHeader;
}

Future<String> getDeviceId() async {
  String deviceId;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo androidDeviceInfo = await deviceInfo.iosInfo;
    deviceId = androidDeviceInfo.identifierForVendor;
  }
  return deviceId;
}

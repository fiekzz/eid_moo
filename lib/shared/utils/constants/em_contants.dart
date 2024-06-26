import 'package:flutter/foundation.dart';

class Constants {
  static const String prodDomain = 'eidmoo-backend.fiekzz.com';
  static const String devDomain = '659d-143-198-92-51.ngrok-free.app';
  static const String domain = kDebugMode ? devDomain : prodDomain;
  static const String protocol = 'https';
}
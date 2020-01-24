import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMultiChipSelect {
  static const MethodChannel _channel =
      const MethodChannel('flutter_multi_chip_select');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

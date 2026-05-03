import 'package:flutter/services.dart';

class NativeDistractionBlockService {
  static const _channel = MethodChannel('com.focusy/blocker');

  Future<void> blockDistractingApps() async {
    try {
      await _channel.invokeMethod('startBlocking');
    } catch (e) {
      // Ignore if native channel fails
    }
  }

  Future<void> unblockDistractingApps() async {
    try {
      await _channel.invokeMethod('stopBlocking');
    } catch (e) {
      // Ignore if native channel fails
    }
  }
}


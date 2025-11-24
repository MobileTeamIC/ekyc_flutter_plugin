import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ekyc_config.dart';

/// Main eKYC method channel service
class EkycMethodChannel {
  static const MethodChannel _channel =
      MethodChannel('flutter.sdk.ic_ekyc/integrate');

  const EkycMethodChannel();

  /// Start full eKYC flow (OCR + Face verification)
  Future<Map<String, dynamic>> startEkycFull(ICEkycConfig config) async {
    return _invokeMethod('startEkycFull', config);
  }

  /// Start OCR only flow
  Future<Map<String, dynamic>> startEkycOcr(ICEkycConfig config) async {
    return _invokeMethod('startEkycOcr', config);
  }

  /// Start OCR front side only flow
  Future<Map<String, dynamic>> startEkycOcrFront(ICEkycConfig config) async {
    return _invokeMethod('startEkycOcrFront', config);
  }

  /// Start OCR back side only flow
  Future<Map<String, dynamic>> startEkycOcrBack(ICEkycConfig config) async {
    return _invokeMethod('startEkycOcrBack', config);
  }

  /// Start face verification only flow
  Future<Map<String, dynamic>> startEkycFace(ICEkycConfig config) async {
    return _invokeMethod('startEkycFace', config);
  }

  /// Start Scan QR Code flow
  Future<Map<String, dynamic>> startEkycScanQRCode(ICEkycConfig config) async {
    return _invokeMethod('startEkycScanQRCode', config);
  }

  /// Generic method to invoke native iOS methods
  Future<Map<String, dynamic>> _invokeMethod(
      String methodName, ICEkycConfig config) async {
    try {
      final dynamic result =
          await _channel.invokeMethod(methodName, config.toMap());

      debugPrint('EkycMethodChannel: $methodName - result: $result');

      return jsonDecode(result);
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    } catch (e) {
      throw PlatformException(
        code: 'UNKNOWN_ERROR',
        message: 'Unknown error occurred: $e',
      );
    }
  }
}
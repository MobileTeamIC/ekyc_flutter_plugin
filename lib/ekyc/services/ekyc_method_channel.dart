import 'dart:convert';
import 'package:flutter/services.dart';

import 'ekyc_config.dart';

/// Main eKYC method channel service
class EkycMethodChannel {
  static const MethodChannel _channel =
      MethodChannel('flutter.sdk.ic_ekyc/integrate');

  const EkycMethodChannel();

  /// Start full eKYC flow (OCR + Face verification)
  Future<Map<String, dynamic>> startEkycFull(EkycConfig config) async {
    return _invokeMethod('startEkycFull', config);
  }

  /// Start OCR only flow
  Future<Map<String, dynamic>> startEkycOcr(EkycConfig config) async {
    return _invokeMethod('startEkycOcr', config);
  }

  /// Start OCR front side only flow
  Future<Map<String, dynamic>> startEkycOcrFront(EkycConfig config) async {
    return _invokeMethod('startEkycOcrFront', config);
  }

  /// Start OCR back side only flow
  Future<Map<String, dynamic>> startEkycOcrBack(EkycConfig config) async {
    return _invokeMethod('startEkycOcrBack', config);
  }

  /// Start face verification only flow
  Future<Map<String, dynamic>> startEkycFace(EkycConfig config) async {
    return _invokeMethod('startEkycFace', config);
  }

  /// Start Scan QR Code flow
  Future<Map<String, dynamic>> startEkycScanQRCode(EkycConfig config) async {
    return _invokeMethod('startEkycScanQRCode', config);
  }

  /// Generic method to invoke native iOS methods
  Future<Map<String, dynamic>> _invokeMethod(
      String methodName, EkycConfig config) async {
    try {
      final dynamic result =
          await _channel.invokeMethod(methodName, config.toMap());

      print('result: $result');

      return jsonDecode(result);
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Failed to invoke $methodName: ${e.message}',
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

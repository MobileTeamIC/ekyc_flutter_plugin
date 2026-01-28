import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ekyc_config.dart';
import 'ekyc_key_result.dart';

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

      final Map<String, dynamic> decodedResult = jsonDecode(result);

      // Convert JSON string fields to proper Dart objects
      return _convertJsonStringFields(decodedResult);
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

  /// Converts specific JSON string fields to proper Dart Map/List objects.
  /// - [ICEkycKeyResult.qrCodeResultDetail]: StringJson → Map<String, dynamic>
  /// - [ICEkycKeyResult.retryQRCodeResult]: StringArrayJson → List<Map<String, dynamic>>
  Map<String, dynamic> _convertJsonStringFields(Map<String, dynamic> result) {
    final Map<String, dynamic> convertedResult = Map.from(result);

    // Convert qrCodeResultDetail from StringJson to Map<String, dynamic>
    if (convertedResult.containsKey(ICEkycKeyResult.qrCodeResultDetail)) {
      final dynamic value = convertedResult[ICEkycKeyResult.qrCodeResultDetail];
      if (value is String && value.isNotEmpty) {
        try {
          convertedResult[ICEkycKeyResult.qrCodeResultDetail] = jsonDecode(value) as Map<String, dynamic>;
        } catch (e) {
          debugPrint('Failed to parse ${ICEkycKeyResult.qrCodeResultDetail}: $e');
        }
      }
    }

    // Convert retryQRCodeResult from StringArrayJson to List<Map<String, dynamic>>
    if (convertedResult.containsKey(ICEkycKeyResult.retryQRCodeResult)) {
      final dynamic value = convertedResult[ICEkycKeyResult.retryQRCodeResult];
      if (value is String && value.isNotEmpty) {
        try {
          final List<dynamic> decoded = jsonDecode(value) as List<dynamic>;
          convertedResult[ICEkycKeyResult.retryQRCodeResult] =
              decoded.map((item) => item as Map<String, dynamic>).toList();
        } catch (e) {
          debugPrint('Failed to parse ${ICEkycKeyResult.retryQRCodeResult}: $e');
        }
      }
    }

    return convertedResult;
  }
}
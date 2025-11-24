import 'services/ekyc_config.dart';
import 'services/ekyc_response.dart';
import 'services/ekyc_method_channel.dart';

/// Main eKYC service
/// Provides unified response structure with status and data
class ICEkyc {
  final EkycMethodChannel _methodChannel;

  const ICEkyc({EkycMethodChannel? methodChannel})
      : _methodChannel = methodChannel ?? const EkycMethodChannel();

  static const ICEkyc _instance = ICEkyc();

  static ICEkyc get instance => _instance;

  /// Start full eKYC flow (OCR + Face verification)
  Future<Map<String, dynamic>> startEkycFull(ICEkycConfig config) async {
    return _methodChannel.startEkycFull(config);
  }

  /// Start OCR only flow
  Future<Map<String, dynamic>> startEkycOcr(ICEkycConfig config) async {
    return _methodChannel.startEkycOcr(config);
  }

  /// Start OCR front side only flow
  Future<Map<String, dynamic>> startEkycOcrFront(ICEkycConfig config) async {
    return _methodChannel.startEkycOcrFront(config);
  }

  /// Start OCR back side only flow
  Future<Map<String, dynamic>> startEkycOcrBack(ICEkycConfig config) async {
    return _methodChannel.startEkycOcrBack(config);
  }

  /// Start face verification only flow
  Future<Map<String, dynamic>> startEkycFace(ICEkycConfig config) async {
    return _methodChannel.startEkycFace(config);
  }

  /// Start Scan QR Code flow
  Future<Map<String, dynamic>> startEkycScanQRCode(ICEkycConfig config) async {
    return _methodChannel.startEkycScanQRCode(config);
  }
}

// import 'package:flutter/services.dart';

// import 'ekyc_config.dart';
// import 'ekyc_response.dart';
// import 'enum_ekyc.dart';

// /// Main eKYC method channel service
// class EkycMethodChannel {
//   static const MethodChannel _channel =
//       MethodChannel('flutter.sdk.ic_ekyc/integrate');

//   const EkycMethodChannel();

//   /// Start full eKYC flow (OCR + Face verification)
//   Future<EkycResponse> startEkycFull(ICEkycConfig config) async {
//     return _invokeMethod('startEkycFull', config);
//   }

//   /// Start OCR only flow
//   Future<EkycResponse> startEkycOcr(ICEkycConfig config) async {
//     return _invokeMethod('startEkycOcr', config);
//   }

//   /// Start OCR front side only flow
//   Future<EkycResponse> startEkycOcrFront(ICEkycConfig config) async {
//     return _invokeMethod('startEkycOcrFront', config);
//   }

//   /// Start OCR back side only flow
//   Future<EkycResponse> startEkycOcrBack(ICEkycConfig config) async {
//     return _invokeMethod('startEkycOcrBack', config);
//   }

//   /// Start face verification only flow
//   Future<EkycResponse> startEkycFace(ICEkycConfig config) async {
//     return _invokeMethod('startEkycFace', config);
//   }

//   /// Start Scan QR Code flow
//   Future<EkycResponse> startEkycScanQRCode(ICEkycConfig config) async {
//     return _invokeMethod('startEkycScanQRCode', config);
//   }

//   Future<EkycResponse> _invokeMethod(
//       String methodName, ICEkycConfig config) async {
//     try {
//       final dynamic result =
//           await _channel.invokeMethod(methodName, config.toMap());

//       // Native returns JSON string, parse it to EkycResponse
//       if (result is String) {
//         return EkycResponse.fromJson(result);
//       } else {
//         // Fallback: if result is not a string, wrap it as failed
//         return EkycResponse(
//           status: EkycStatus.failed,
//           errorData: {
//             'error': 'Invalid response format from native',
//             'result': result,
//           },
//         );
//       }
//     } on PlatformException catch (e) {
//       // Platform exceptions (like method not implemented) are wrapped as failed response
//       return EkycResponse(
//         status: EkycStatus.failed,
//         errorData: {
//           'code': e.code,
//           'message': e.message ?? 'Platform exception occurred',
//           'details': e.details,
//         },
//       );
//     } catch (e) {
//       // Other exceptions are wrapped as failed response
//       return EkycResponse(
//         status: EkycStatus.failed,
//         errorData: {
//           'error': 'Unknown error occurred',
//           'message': e.toString(),
//         },
//       );
//     }
//   }
// }
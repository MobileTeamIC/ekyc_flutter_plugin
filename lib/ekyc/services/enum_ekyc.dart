/// Flutter-side enums mirroring iOS SDK enums
enum VersionSdk { normal, proOval }

enum DocumentType {
  identityCard,
  idCardChipBased,
  passport,
  driverLicense,
  militaryIdCard
}

enum CameraPosition { positionFront, positionBack }

enum LivenessFaceMode { noneCheckFace, ibeta, standard }

enum ValidateDocumentType { none, basic, medium, advance }

enum FlowType { full, ocr, ocrFront, ocrBack, face, scanQRCode, none }

enum LanguageSdk { icekyc_vi, icekyc_en }

enum ModeButtonHeaderBar { leftButton, rightButton }

/// Last screen where user cancelled the eKYC operation
/// Unified format based on iOS ScreenType enum
enum EkycLastScreen {
  cancelPermission,
  helpDocument,
  scanQRCode,
  captureFront,
  captureBack,
  helpOval,
  authenFarFace,
  authenNearFace,
  helpFaceBasic,
  captureFaceBasic,
  processing,
  done,
  unknown;

  /// Convert from string value (from native iOS/Android)
  /// iOS format: "CancelPermission", "HelpDocument", etc.
  /// Android format: "Help_Document", "Scan_QR", etc. (will be converted to iOS format)
  static EkycLastScreen fromString(String? value) {
    if (value == null || value.isEmpty) {
      return EkycLastScreen.unknown;
    }

    // Normalize Android format to iOS format
    final normalized = _normalizeAndroidFormat(value);

    switch (normalized) {
      case 'CancelPermission':
        return EkycLastScreen.cancelPermission;
      case 'HelpDocument':
        return EkycLastScreen.helpDocument;
      case 'ScanQRCode':
        return EkycLastScreen.scanQRCode;
      case 'CaptureFront':
        return EkycLastScreen.captureFront;
      case 'CaptureBack':
        return EkycLastScreen.captureBack;
      case 'HelpOval':
        return EkycLastScreen.helpOval;
      case 'AuthenFarFace':
        return EkycLastScreen.authenFarFace;
      case 'AuthenNearFace':
        return EkycLastScreen.authenNearFace;
      case 'HelpFaceBasic':
        return EkycLastScreen.helpFaceBasic;
      case 'CaptureFaceBasic':
        return EkycLastScreen.captureFaceBasic;
      case 'Processing':
        return EkycLastScreen.processing;
      case 'Done':
        return EkycLastScreen.done;
      default:
        return EkycLastScreen.unknown;
    }
  }

  /// Convert Android format to iOS format
  /// Example: "Help_Document" -> "HelpDocument", "Scan_QR" -> "ScanQRCode"
  static String _normalizeAndroidFormat(String value) {
    // Handle Android format with underscores
    if (value.contains('_')) {
      // Map Android specific values to iOS format
      switch (value) {
        case 'Help_Document':
          return 'HelpDocument';
        case 'Scan_QR':
          return 'ScanQRCode';
        case 'Capture_Front':
          return 'CaptureFront';
        case 'Preview_Front':
          return 'CaptureFront'; // Map preview to capture
        case 'Capture_Back':
          return 'CaptureBack';
        case 'Preview_Back':
          return 'CaptureBack'; // Map preview to capture
        case 'Help_Oval':
          return 'HelpOval';
        case 'Authen_Far_Face':
          return 'AuthenFarFace';
        case 'Authen_Near_Face':
          return 'AuthenNearFace';
        case 'Help_Face_Basic':
          return 'HelpFaceBasic';
        case 'Capture_Face_Basic':
          return 'CaptureFaceBasic';
        case 'Preview_Face_Basic':
          return 'CaptureFaceBasic'; // Map preview to capture
        case 'Processing':
          return 'Processing';
        case 'Done':
          return 'Done';
        case 'None':
          return 'Unknown';
        default:
          // Try to convert underscore format to camelCase
          final parts = value.split('_');
          if (parts.length > 1) {
            return parts.map((part) {
              if (part.isEmpty) return '';
              return part[0].toUpperCase() + part.substring(1).toLowerCase();
            }).join();
          }
          return value;
      }
    }
    // Already in iOS format or unknown
    return value;
  }

  /// Convert to string value (iOS format)
  String get value {
    switch (this) {
      case EkycLastScreen.cancelPermission:
        return 'CancelPermission';
      case EkycLastScreen.helpDocument:
        return 'HelpDocument';
      case EkycLastScreen.scanQRCode:
        return 'ScanQRCode';
      case EkycLastScreen.captureFront:
        return 'CaptureFront';
      case EkycLastScreen.captureBack:
        return 'CaptureBack';
      case EkycLastScreen.helpOval:
        return 'HelpOval';
      case EkycLastScreen.authenFarFace:
        return 'AuthenFarFace';
      case EkycLastScreen.authenNearFace:
        return 'AuthenNearFace';
      case EkycLastScreen.helpFaceBasic:
        return 'HelpFaceBasic';
      case EkycLastScreen.captureFaceBasic:
        return 'CaptureFaceBasic';
      case EkycLastScreen.processing:
        return 'Processing';
      case EkycLastScreen.done:
        return 'Done';
      case EkycLastScreen.unknown:
        return 'Unknown';
    }
  }
}

/// Status of eKYC operation result
enum EkycStatus {
  success,
  cancelled,
  failed;

  /// Convert from string value (from native)
  static EkycStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'SUCCESS':
        return EkycStatus.success;
      case 'CANCELLED':
        return EkycStatus.cancelled;
      case 'FAILED':
        return EkycStatus.failed;
      default:
        return EkycStatus.failed;
    }
  }

  /// Convert to string value (for native)
  String get value {
    switch (this) {
      case EkycStatus.success:
        return 'SUCCESS';
      case EkycStatus.cancelled:
        return 'CANCELLED';
      case EkycStatus.failed:
        return 'FAILED';
    }
  }
}

String _versionSdkValue(VersionSdk v) {
  switch (v) {
    case VersionSdk.normal:
      return 'normal';
    case VersionSdk.proOval:
      return 'prooval';
  }
}

String _documentTypeValue(DocumentType v) {
  switch (v) {
    case DocumentType.identityCard:
      return 'identitycard';
    case DocumentType.idCardChipBased:
      return 'idcardchipbased';
    case DocumentType.passport:
      return 'passport';
    case DocumentType.driverLicense:
      return 'driverlicense';
    case DocumentType.militaryIdCard:
      return 'militaryidcard';
  }
}

String _cameraPositionValue(CameraPosition v) {
  switch (v) {
    case CameraPosition.positionFront:
      return 'positionfront';
    case CameraPosition.positionBack:
      return 'positionback';
  }
}

String _livenessFaceModeValue(LivenessFaceMode v) {
  switch (v) {
    case LivenessFaceMode.noneCheckFace:
      return 'nonecheckface';
    case LivenessFaceMode.ibeta:
      return 'ibeta';
    case LivenessFaceMode.standard:
      return 'standard';
  }
}

String _validateDocumentTypeValue(ValidateDocumentType v) {
  switch (v) {
    case ValidateDocumentType.none:
      return 'none';
    case ValidateDocumentType.basic:
      return 'basic';
    case ValidateDocumentType.medium:
      return 'medium';
    case ValidateDocumentType.advance:
      return 'advance';
  }
}

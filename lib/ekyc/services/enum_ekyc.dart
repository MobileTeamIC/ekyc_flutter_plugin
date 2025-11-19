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

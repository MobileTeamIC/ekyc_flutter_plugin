import 'enum_ekyc.dart';

/// Configuration class for eKYC SDK parameters
class ICEkycConfig {
  // Required authentication parameters
  final String? accessToken;
  final String? tokenId;
  final String? tokenKey;
  final DocumentType? documentType;
  final ValidateDocumentType? validateDocumentType;
  final String? hashImageCompare;

  final VersionSdk? versionSdk;

  final LivenessFaceMode? checkLivenessFace;

  final bool? isShowTutorial;
  final bool? isEnableCompare;
  final bool? isCheckMaskedFace;
  final bool? isCheckLivenessCard;
  final bool? isValidatePostcode;
  final bool? isEnableGotIt;
  final bool? isShowLogo;
  final bool? isTurnOffCallService;
  final bool? isEnableScanQRCode;
  final bool? isShowQRCodeResult;

  // Additional configuration
  final String? changeBaseUrl;
  final String? challengeCode;
  final LanguageSdk? languageSdk;
  final String? hashFrontOcr;

  const ICEkycConfig({
     this.accessToken,
     this.tokenId,
     this.tokenKey,
    this.hashImageCompare,
    this.documentType,
    this.validateDocumentType,
    this.versionSdk,
    this.checkLivenessFace,
    this.isShowTutorial,
    this.isEnableCompare,
    this.isCheckMaskedFace,
    this.isCheckLivenessCard,
    this.isValidatePostcode,
    this.isEnableGotIt,
    this.isShowLogo,
    this.changeBaseUrl,
    this.languageSdk,
    this.hashFrontOcr,
    this.isTurnOffCallService,
    this.isEnableScanQRCode,
    this.isShowQRCodeResult,
    this.challengeCode,
  });

  /// Convert to Map for method channel
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = { };

    // Add optional parameters only if they are not null
    if (accessToken != null) map['access_token'] = accessToken!;
    if (tokenId != null) map['token_id'] = tokenId!;
    if (tokenKey != null) map['token_key'] = tokenKey!;
    if (documentType != null) map['document_type'] = documentType!.name;
    if (validateDocumentType != null) {
      map['validate_document_type'] = validateDocumentType!.name;
    }
    if (versionSdk != null) map['version_sdk'] = versionSdk!.name;
    if (checkLivenessFace != null) {
      map['check_liveness_face'] = checkLivenessFace!.name;
    }
    if (isShowTutorial != null) map['is_show_tutorial'] = isShowTutorial;
    if (isEnableCompare != null) map['is_enable_compare'] = isEnableCompare;
    if (isCheckMaskedFace != null) {
      map['is_check_masked_face'] = isCheckMaskedFace;
    }
    if (isCheckLivenessCard != null) {
      map['is_check_liveness_card'] = isCheckLivenessCard;
    }
    if (isValidatePostcode != null) {
      map['is_validate_postcode'] = isValidatePostcode;
    }
    if (isEnableGotIt != null) map['is_enable_gotit'] = isEnableGotIt;
    if (isShowLogo != null) map['is_show_logo'] = isShowLogo;
    if (isTurnOffCallService != null) map['is_turn_off_call_service'] = isTurnOffCallService;
    if (isEnableScanQRCode != null) map['is_enable_scan_qrcode'] = isEnableScanQRCode;
    if (isShowQRCodeResult != null) map['is_show_qrcode_result'] = isShowQRCodeResult;
    if (changeBaseUrl != null) map['change_base_url'] = changeBaseUrl!;
    if (languageSdk != null) map['language_sdk'] = languageSdk!.name;
    if (hashFrontOcr != null) map['hash_front_ocr'] = hashFrontOcr!;
    if (hashImageCompare != null) map['hash_image_compare'] = hashImageCompare!;
    if (challengeCode != null) map['challenge_code'] = challengeCode!;
    return map;
  }
}

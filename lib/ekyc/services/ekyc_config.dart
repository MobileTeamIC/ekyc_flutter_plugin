import 'enum_ekyc.dart';


/// Configuration class for eKYC SDK parameters
class EkycConfig {
  // Required authentication parameters
  final String accessToken;
  final String tokenId;
  final String tokenKey;
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

  // Additional configuration
  final String? changeBaseUrl;
  final LanguageSdk? languageSdk;
  final String? hashFrontOcr;

  const EkycConfig({
    required this.accessToken,
    required this.tokenId,
    required this.tokenKey,
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
  });

  /// Convert to Map for method channel
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'access_token': accessToken,
      'token_id': tokenId,
      'token_key': tokenKey,
      'version_sdk': versionSdk?.name,
      'document_type': documentType?.name,
      'is_show_tutorial': isShowTutorial,
      'is_enable_compare': isEnableCompare,
      'is_check_masked_face': isCheckMaskedFace,
      'check_liveness_face': checkLivenessFace?.name,
      'is_check_liveness_card': isCheckLivenessCard,
      'is_validate_postcode': isValidatePostcode,
      'validate_document_type': validateDocumentType?.name,
      'change_base_url': changeBaseUrl,
      'is_enable_gotit': isEnableGotIt,
      'language_sdk': languageSdk?.name,
      'is_show_logo': isShowLogo,
      'hash_front_ocr': hashFrontOcr,
      'hash_image_compare': hashImageCompare,
    };

    // Add optional parameters only if they are not null
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

    if (changeBaseUrl != null) map['change_base_url'] = changeBaseUrl!;
    if (languageSdk != null) map['language_sdk'] = languageSdk!.name;
    if (hashFrontOcr != null) map['hash_front_ocr'] = hashFrontOcr!;
    if (hashImageCompare != null) map['hash_image_compare'] = hashImageCompare!;

    return map;
  }
}

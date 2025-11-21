import 'ekyc_config.dart';
import 'enum_ekyc.dart';

/// Predefined configurations for common use cases
class ICEkycPresets {
  /// Create default configuration for full eKYC flow
  static ICEkycConfig fullEkyc({
     String accessToken = '',
     String tokenId = '',
     String tokenKey = '',
    DocumentType documentType = DocumentType.identityCard,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    VersionSdk versionSdk = VersionSdk.proOval,
    LivenessFaceMode checkLivenessFace = LivenessFaceMode.noneCheckFace,
    bool isShowTutorial = false,
    bool isEnableCompare = false,
    bool isCheckMaskedFace = false,
    bool isCheckLivenessCard = false,
    bool isValidatePostcode = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    String challengeCode = '',
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        documentType: documentType,
        isShowTutorial: isShowTutorial,
        isEnableCompare: isEnableCompare,
        isCheckMaskedFace: isCheckMaskedFace,
        checkLivenessFace: checkLivenessFace,
        isCheckLivenessCard: isCheckLivenessCard,
        isValidatePostcode: isValidatePostcode,
        validateDocumentType: validateDocumentType,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
        versionSdk: versionSdk,
        isTurnOffCallService: isTurnOffCallService,
        isEnableScanQRCode: isEnableScanQRCode,
        isShowQRCodeResult: isShowQRCodeResult,
        challengeCode: challengeCode,
      );

  /// Create configuration for OCR only flow
  static ICEkycConfig ocrOnly({
     String accessToken = '',
     String tokenId = '',
     String tokenKey = '',
    DocumentType documentType = DocumentType.identityCard,
    String changeBaseUrl = '',
    bool isShowTutorial = false,
    bool isCheckLivenessCard = false,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    String challengeCode = '',
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        documentType: documentType,
        isShowTutorial: isShowTutorial,
        isCheckLivenessCard: isCheckLivenessCard,
        validateDocumentType: validateDocumentType,
        isValidatePostcode: isValidatePostcode,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
        isTurnOffCallService: isTurnOffCallService,
        isEnableScanQRCode: isEnableScanQRCode,
        isShowQRCodeResult: isShowQRCodeResult,
        challengeCode: challengeCode,
      );

  //MARK: - OCR FONT
    /// Luồng chỉ thực hiện đọc giấy tờ chỉ mặt trước: OCR Front
    /// 
    /// Thực hiện OCR giấy tờ một bước: chụp mặt trước giấy tờ
    /// 
    /// - Parameters:
    ///   - controller: Root view controller để present eKYC SDK
    ///   - info: Dictionary chứa các thông số cấu hình eKYC
    /// 
    /// - Required Parameters (info):
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    /// 
    /// - Optional Parameters (info):
    ///   - flow_type: Loại luồng thực hiện ("ocrfront", "none", "scanqr", "ocrback", "ocr", "full", "face")
    ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
    ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
    ///   - change_base_url: Đường dẫn API tùy chỉnh
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
  /// Create configuration for OCR front side only flow
  static ICEkycConfig ocrFront({
     String accessToken = '',
     String tokenId = '',
     String tokenKey = '',
    DocumentType documentType = DocumentType.identityCard,
    bool isShowTutorial = false,
    bool isCheckLivenessCard = false,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    String challengeCode = '',
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        documentType: documentType,
        isShowTutorial: isShowTutorial,
        isCheckLivenessCard: isCheckLivenessCard,
        validateDocumentType: validateDocumentType,
        isValidatePostcode: isValidatePostcode,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
        isTurnOffCallService: isTurnOffCallService,
        isEnableScanQRCode: isEnableScanQRCode,
        isShowQRCodeResult: isShowQRCodeResult,
        challengeCode: challengeCode,
      );

  //MARK: - ORC BACK
  /// Luồng chỉ thực hiện đọc giấy tờ chỉ mặt sau: OCR Back
  /// 
  /// Thực hiện OCR giấy tờ một bước: chụp mặt sau giấy tờ
  /// 
  /// - Parameters:
  ///   - controller: Root view controller để present eKYC SDK
  ///   - info: Dictionary chứa các thông số cấu hình eKYC
  /// 
  /// - Required Parameters (info):
  ///   - access_token: Mã truy cập từ eKYC admin dashboard
  ///   - token_id: Token ID từ eKYC admin dashboard
  ///   - token_key: Token key từ eKYC admin dashboard
  /// 
  /// - Optional Parameters (info):
  ///   - flow_type: Loại luồng thực hiện ("ocrback", "none", "scanqr", "ocrfront", "ocr", "full", "face")
  ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
  ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
  ///   - hash_front_ocr: Hash của kết quả OCR mặt trước (bắt buộc cho ocrback)
  ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
  ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
  ///   - is_validate_postcode: Bật/tắt chức năng kiểm tra mã bưu điện ("true"/"false")
  ///   - change_base_url: Đường dẫn API tùy chỉnh
  ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
  ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
  ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
  /// Create configuration for OCR back side only flow
  static ICEkycConfig ocrBack({
     String accessToken = '',
     String tokenId = '',
     String tokenKey = '',
     String hashFrontOcr = '',
    DocumentType documentType = DocumentType.identityCard,
    bool isShowTutorial = true,
    bool isCheckLivenessCard = true,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = true,
    bool isEnableGotIt = true,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        documentType: documentType,
        isShowTutorial: isShowTutorial,
        hashFrontOcr: hashFrontOcr,
        isCheckLivenessCard: isCheckLivenessCard,
        validateDocumentType: validateDocumentType,
        isValidatePostcode: isValidatePostcode,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
      );

 //MARK: - FACE
  /// Luồng chỉ thực hiện xác thực khuôn mặt: Face Verification
  /// 
  /// Thực hiện chụp ảnh Oval xa gần và thực hiện các chức năng tùy vào cấu hình: Compare, Verify, Mask, Liveness Face
  /// 
  /// - Parameters:
  ///   - controller: Root view controller để present eKYC SDK
  ///   - info: Dictionary chứa các thông số cấu hình eKYC
  /// 
  /// - Required Parameters (info):
  ///   - access_token: Mã truy cập từ eKYC admin dashboard
  ///   - token_id: Token ID từ eKYC admin dashboard
  ///   - token_key: Token key từ eKYC admin dashboard
  /// 
  /// - Optional Parameters (info):
  ///   - flow_type: Loại luồng thực hiện ("face", "none", "scanqr", "ocrfront", "ocrback", "ocr", "full")
  ///   - version_sdk: Phiên bản SDK cho chụp ảnh chân dung ("normal", "prooval")
  ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
  ///   - is_enable_compare: Bật/tắt chức năng so sánh ảnh chân dung ("true"/"false")
  ///   - is_check_masked_face: Bật/tắt chức năng kiểm tra che mặt ("true"/"false")
  ///   - check_liveness_face: Chức năng kiểm tra ảnh chân dung chụp trực tiếp ("nonecheckface", "ibeta", "standard")
  ///   - change_base_url: Đường dẫn API tùy chỉnh
  ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
  ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
  ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
  /// Create configuration for face verification only
  static ICEkycConfig faceVerification({
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    DocumentType documentType = DocumentType.identityCard,
    bool isShowTutorial = false,
    bool isCheckLivenessCard = false,
    bool isCheckMaskedFace = false,
    LivenessFaceMode checkLivenessFace = LivenessFaceMode.noneCheckFace,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    VersionSdk versionSdk = VersionSdk.proOval,
    String challengeCode = '',
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        versionSdk: versionSdk,
        isShowTutorial: isShowTutorial,
        isCheckMaskedFace: isCheckMaskedFace,
        checkLivenessFace: checkLivenessFace,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
        isTurnOffCallService: isTurnOffCallService,
        isEnableScanQRCode: isEnableScanQRCode,
        isShowQRCodeResult: isShowQRCodeResult,
        challengeCode: challengeCode,
      );

  //MARK: - SCANQR CODE
    /// Luồng chỉ thực hiện quét QR code: Scan QR Code
    /// 
    /// Thực hiện quét QR code để lấy thông tin từ QR code
    /// 
    /// - Parameters:
    ///   - controller: Root view controller để present eKYC SDK
    ///   - info: Dictionary chứa các thông số cấu hình eKYC
    /// 
    /// - Required Parameters (info):
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    /// 
    /// - Optional Parameters (info):
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
  /// Create configuration for scan QR code flow
  static ICEkycConfig scanQRCode({
    required String accessToken,
    required String tokenId,
    required String tokenKey,
    bool isShowTutorial = true,
    bool isEnableGotIt = true,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = true,
  }) =>
      ICEkycConfig(
        accessToken: accessToken,
        tokenId: tokenId,
        tokenKey: tokenKey,
        isShowTutorial: isShowTutorial,
        isEnableGotIt: isEnableGotIt,
        languageSdk: languageSdk,
        isShowLogo: isShowLogo,
      );
}

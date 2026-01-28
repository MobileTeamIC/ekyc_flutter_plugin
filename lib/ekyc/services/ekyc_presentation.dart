import 'package:flutter/material.dart';
import 'ekyc_config.dart';
import 'enum_ekyc.dart';

/// Predefined configurations for common use cases
class ICEkycPresets {
  /// Create default configuration for full eKYC flow
  static ICEkycConfig fullEkyc({
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String changeBaseUrl = '',
    DocumentType documentType = DocumentType.identityCard,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    VersionSdk versionSdk = VersionSdk.proOval,
    LivenessFaceMode checkLivenessFace = LivenessFaceMode.noneCheckFace,
    String challengeCode = '',
    int? numberTimesRetryScanQRCode,
    int? timeoutQRCodeFlow,
    bool isEnableCompare = false,
    bool isCheckMaskedFace = false,
    bool isCheckLivenessCard = false,
    bool isValidatePostcode = false,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,

    //Config ui
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,

    
    /// Đường dẫn Logo thương hiệu
    String? logo,
    
    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,

    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,
    
    //==== Cấu hình màu sắc giao diện ====
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,

  }) => ICEkycConfig(
    accessToken: accessToken,
    tokenId: tokenId,
    tokenKey: tokenKey,
    changeBaseUrl: changeBaseUrl,
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
    modeButtonHeaderBar: modeButtonHeaderBar,
    numberTimesRetryScanQRCode: numberTimesRetryScanQRCode,
    timeoutQRCodeFlow: timeoutQRCodeFlow,
    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,
    
    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),

    
  );

  /// Create configuration for OCR only flow
  static ICEkycConfig ocrOnly({
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    DocumentType documentType = DocumentType.identityCard,
    String changeBaseUrl = '',
    bool isCheckLivenessCard = false,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    String challengeCode = '',
    int? numberTimesRetryScanQRCode,
    int? timeoutQRCodeFlow,

    // Config UI
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,

    /// Đường dẫn Logo thương hiệu
    String? logo,
    
    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,

    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,

        
    // MARK: - Cấu hình màu sắc giao diện
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,

  }) => ICEkycConfig(
    accessToken: accessToken,
    tokenId: tokenId,
    tokenKey: tokenKey,
    documentType: documentType,
    changeBaseUrl: changeBaseUrl,
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
    modeButtonHeaderBar: modeButtonHeaderBar,
    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,

    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),
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
    String changeBaseUrl = '',
    bool isCheckLivenessCard = false,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    String challengeCode = '',

     // Config UI
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,

    /// Đường dẫn Logo thương hiệu
    String? logo,
    
    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,

    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,
        
    // MARK: - Cấu hình màu sắc giao diện
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,
  }) => ICEkycConfig(
    accessToken: accessToken,
    tokenId: tokenId,
    tokenKey: tokenKey,
    documentType: documentType,
    changeBaseUrl: changeBaseUrl,
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
    modeButtonHeaderBar: modeButtonHeaderBar,
    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,

    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),
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
    String changeBaseUrl = '',
    bool isCheckLivenessCard = true,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = true,

        // Config UI
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,

    /// Đường dẫn Logo thương hiệu
    String? logo,
    
    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,

    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,
  
    // MARK: - Cấu hình màu sắc giao diện
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,

  }) => ICEkycConfig(
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
    modeButtonHeaderBar: modeButtonHeaderBar,

    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,

    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),
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
    bool isCheckLivenessCard = false,
    bool isCheckMaskedFace = false,
    LivenessFaceMode checkLivenessFace = LivenessFaceMode.noneCheckFace,
    ValidateDocumentType validateDocumentType = ValidateDocumentType.basic,
    bool isValidatePostcode = false,
    bool isTurnOffCallService = true,
    bool isEnableScanQRCode = false,
    bool isShowQRCodeResult = false,
    VersionSdk versionSdk = VersionSdk.proOval,
    String challengeCode = '',

  // Config UI
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,

    /// Đường dẫn Logo thương hiệu
    String? logo,
    
    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,

    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,

    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,

    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,


        
    // MARK: - Cấu hình màu sắc giao diện
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,
    }) => ICEkycConfig(
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
    modeButtonHeaderBar: modeButtonHeaderBar,
    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,

    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),
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
  ///   - mode_button_header_bar: Kiểu nút trong header bar ("left_button", "right_button")
  ///   - number_times_retry_scan_qr_code: Số lần thử quét QR code
  ///   - timeout_qr_code_flow: Thời gian timeout cho luồng quét QR code
  /// Create configuration for scan QR code flow
  static ICEkycConfig scanQRCode({
    required String accessToken,
    required String tokenId,
    required String tokenKey,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isTurnOffCallService = true,
    LanguageSdk languageSdk = LanguageSdk.icekyc_vi,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,
    int? numberTimesRetryScanQRCode,
    int? timeoutQRCodeFlow,

    //Config UI
    /// Đường dẫn Logo thương hiệu
    String? logo,

    /// Kích thước Ảnh thương hiệu. Mặc định 148.0 * 20.0 (chiều rộng * chiều cao)
    double? widthLogo,
    double? heightLogo,

    /// Đường dẫn Logo trong màn hình chụp ảnh khuôn mặt oval. Mặc định là VNPT AI
    String? logoFaceOval,
    /// Đường dẫn Ảnh hướng dẫn chụp mặt trước
    String? imageTutorialFront,
    /// Đường dẫn Ảnh hướng dẫn chụp mặt sau
    String? imageTutorialBack,
    /// Đường dẫn Ảnh hướng dẫn quét QR code
    String? imageTutorialQRCode,
    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị che
    String? imageTutorialBlur,
    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị nghiêng, mất góc
    String? imageTutorialLostAngle,
    /// Đường dẫn Ảnh hướng dẫn chụp ảnh bị chiếu sáng
    String? imageTutorialGlare,


        
    // MARK: - Cấu hình màu sắc giao diện
    /// Màu nội dung thanh tiêu đề: bao gồm màu chữ và màu nút đóng. Mặc định là 0x142730
    Color? contentColorHeaderBar,
    
    /// Màu nền thanh tiêu đề. Mặc định là trong suốt
    /// Áp dụng cho các màn hình: Các màn hướng dẫn, các màn chụp giấy tờ, màn quét mã QR, màn chụp ảnh chân dung
    Color? backgroundColorHeaderBar,
    
    /// Màu nội dung chính. Mặc định là 0x142730
    /// Áp dụng cho toàn bộ các màn hình
    Color? textColorContentMain,
    
    /// Màu tiêu đề chính. Mặc định 0x00A96F
    /// Áp dụng cho Tiêu đề: CHỤP MẶT TRƯỚC, ẢNH MẶT TRƯỚC, Chấm tròn nhỏ ở màn hình Hướng dẫn, màn hình Preview
    Color? titleColorMain,
    
    /// Màu nền chính. Mặc định là 0xFFFFFF
    /// Áp dụng cho màn Hướng dẫn (Help), màn xem trước (Preview)
    Color? backgroundColorMainScreen,
    
    /// Đường kẻ ngang ngăn cách các nội dung, mặc định 0x142730
    /// Áp dụng trên các màn hình Hướng dẫn, các màn hình Cảnh báo
    Color? backgroundColorLine,
    
    /// Màu nền nút bấm ở trạng thái hoạt động, mặc định 0x00A96F
    Color? backgroundColorActiveButton,
    
    /// Màu nền nút bấm ở trạng thái không hoạt động, mặc định 0xB8C1C6
    Color? backgroundColorDeactiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái hoạt động, mặc định 0xFFFFFF
    Color? titleColorActiveButton,
    
    /// Màu tiêu đề nút bấm ở trạng thái không hoạt động, mặc định 0xFFFFFF
    Color? titleColorDeactiveButton,
    
    /// Màu nền chụp ảnh giấy tờ, quét mã QR, mặc định 0xFFFFFF
    Color? backgroundColorCaptureDocumentScreen,
    
    /// Màu nền chụp ảnh chân dung, mặc định 0xFFFFFF alpha = 0.75
    Color? backgroundColorCaptureFaceScreen,
    
    /// Màu hiệu ứng cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0x00A96F
    Color? effectColorNoticeFace,
    
    /// Màu chữ nội dung trong ô cảnh báo ở màn chụp khuôn mặt Oval, mặc định 0xFFFFFF
    Color? textColorNoticeFace,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ, mặc định 0xCA2A2A
    Color? effectColorNoticeInvalidFace,
    
    /// Màu nội dung trong viền oval khuôn mặt
    Color? colorContentFaceEffect,
    
    /// Màu hiệu ứng cảnh báo giấy tờ hợp lệ
    Color? effectColorNoticeValidDocument,
    
    /// Màu hiệu ứng cảnh báo giấy tờ không hợp lệ
    Color? effectColorNoticeInvalidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ hợp lệ. Mặc định 0x00A96F
    Color? textColorNoticeValidDocument,
    
    /// Màu nội dung trong ô cảnh báo giấy tờ không hợp lệ. Mặc định 0xCA2A2A
    Color? textColorNoticeInvalidDocument,
    
    /// Màu nút chụp ảnh giấy tờ, mặc định 0x142730
    Color? tintColorButtonCapture,
    
    /// Màu đường viền khung chụp mặt Oval, cơ bản, mặc định 0x00A96F
    Color? backgroundColorBorderCaptureFace,
    
    /// Màu nền của các màn hình dạng cảnh báo, mặc định 0xFFFFFF
    Color? backgroundColorPopup,
    
    /// Màu chữ của các màn hình dạng cảnh báo, mặc định 0x000000
    Color? textColorContentPopup,
    
  }) => ICEkycConfig(
    accessToken: accessToken,
    tokenId: tokenId,
    tokenKey: tokenKey,
    isTurnOffCallService: isTurnOffCallService,
    isShowTutorial: isShowTutorial,
    isEnableGotIt: isEnableGotIt,
    languageSdk: languageSdk,
    isShowLogo: isShowLogo,
    modeButtonHeaderBar: modeButtonHeaderBar,
    numberTimesRetryScanQRCode: numberTimesRetryScanQRCode,
    timeoutQRCodeFlow: timeoutQRCodeFlow,

    //Config UI
    logo: logo,
    widthLogo: widthLogo,
    heightLogo: heightLogo,
    logoFaceOval: logoFaceOval,
    imageTutorialFront: imageTutorialFront,
    imageTutorialBack: imageTutorialBack,
    imageTutorialQRCode: imageTutorialQRCode,
    imageTutorialBlur: imageTutorialBlur,
    imageTutorialLostAngle: imageTutorialLostAngle,
    imageTutorialGlare: imageTutorialGlare,

    // Convert Color to int (AARRGGBB format) before passing to native
    contentColorHeaderBar: contentColorHeaderBar?.toARGB32(),
    backgroundColorHeaderBar: backgroundColorHeaderBar?.toARGB32(),
    textColorContentMain: textColorContentMain?.toARGB32(),
    titleColorMain: titleColorMain?.toARGB32(),
    backgroundColorMainScreen: backgroundColorMainScreen?.toARGB32(),
    backgroundColorLine: backgroundColorLine?.toARGB32(),
    backgroundColorActiveButton: backgroundColorActiveButton?.toARGB32(),
    backgroundColorDeactiveButton: backgroundColorDeactiveButton?.toARGB32(),
    titleColorActiveButton: titleColorActiveButton?.toARGB32(),
    titleColorDeactiveButton: titleColorDeactiveButton?.toARGB32(),
    backgroundColorCaptureDocumentScreen: backgroundColorCaptureDocumentScreen?.toARGB32(),
    backgroundColorCaptureFaceScreen: backgroundColorCaptureFaceScreen?.toARGB32(),
    effectColorNoticeFace: effectColorNoticeFace?.toARGB32(),
    textColorNoticeFace: textColorNoticeFace?.toARGB32(),
    effectColorNoticeInvalidFace: effectColorNoticeInvalidFace?.toARGB32(),
    colorContentFaceEffect: colorContentFaceEffect?.toARGB32(),
    effectColorNoticeValidDocument: effectColorNoticeValidDocument?.toARGB32(),
    effectColorNoticeInvalidDocument: effectColorNoticeInvalidDocument?.toARGB32(),
    textColorNoticeValidDocument: textColorNoticeValidDocument?.toARGB32(),
    textColorNoticeInvalidDocument: textColorNoticeInvalidDocument?.toARGB32(),
    tintColorButtonCapture: tintColorButtonCapture?.toARGB32(),
    backgroundColorBorderCaptureFace: backgroundColorBorderCaptureFace?.toARGB32(),
    backgroundColorPopup: backgroundColorPopup?.toARGB32(),
    textColorContentPopup: textColorContentPopup?.toARGB32(),
  );
}

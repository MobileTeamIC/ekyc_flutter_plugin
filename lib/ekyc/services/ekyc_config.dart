import 'enum_ekyc.dart';

/// Configuration class for eKYC SDK parameters
class ICEkycConfig {

//MARK: - CÁC THUỘC TÍNH CƠ BẢN CÀI ĐẶT CHUNG SDK
  final String? accessToken;
  final String? tokenId;
  final String? tokenKey;
  final VersionSdk? versionSdk;
  final FlowType? flowType;
  final LanguageSdk? languageSdk;
  final String? challengeCode;
  final String? inputClientSession;
  final bool? isShowTutorial;
  final bool? isDisableTutorial;
  final bool? isShowRequiredPermissionDecree;
  final bool? isEnableTutorialCardAdvance;
  final bool? isEnableGotIt;
  final bool? isShowSwitchCamera;
  final CameraPosition? cameraPositionForPortrait;
  final double? zoomCamera;
  final int? expiresTime;
  final bool? isTurnOffCallService;
  final double? compressionQualityImage;
  final bool? isEnableAutoBrightness;
  final double? screenBrightness;
  final bool? isSkipPreview;
  final bool? isEnableEncrypt;
  final String? encryptPublicKey;
  final String? modeUploadFile;

// MARK: - CÁC THUỘC TÍNH VỀ GIẤY TỜ
  final DocumentType? documentType;
  final String? hashFrontOcr;
  final bool? isCheckLivenessCard;
  final bool? isEnableScanQRCode;
  final bool? isShowQRCodeResult;
  final ValidateDocumentType? validateDocumentType;
  final bool? isValidatePostcode;
  final List<String>? listBlockedDocument;
  final String? modeVersionOCR;

// MARK: - CÁC THUỘC TÍNH VỀ KHUÔN MẶT
  // final VersionFaceOval modeVersionFaceOval;
  final bool? isEnableCompare;
  final int? compareType;
  final String? hashImageCompare;
  final bool? isCompareGeneral;
  final double? thresLevel;
  final LivenessFaceMode? checkLivenessFace;
  final bool? isCheckMaskedFace;

  // MARK: - CÁC THUỘC TÍNH VỀ VIỆC QUAY VIDEO LẠI QUÁ TRÌNH THỰC HIỆN OCR VÀ FACE TRONG SDK
  final bool? isRecordVideoFace;
  final bool? isRecordVideoDocument;

  // MARK: - CÁC THUỘC TÍNH VỀ MÔI TRƯỜNG PHÁT TRIỂN - URL TÁC VỤ TRONG SDK
  final bool? isEnableWaterMark;
  final bool? isAddMetadataImage;
  final int? timeoutCallApi;
  final String? changeBaseUrl;
  final String? urlUploadImage;
  final String? urlOcr;
  final String? urlOcrFront;
  final String? urlCompare;
  final String? urlCompareGeneral;
  final String? urlVerifyFace;
  final String? urlAddFace;
  final String? urlAddCardId;
  final String? urlLivenessCard;
  final String? urlCheckMaskedFace;
  final String? urlSearchFace;
  final String? urlLivenessFace;
  final String? urlLivenessFace3D;
  final String? urlLogSdk;
  final Map<String, dynamic>? headersRequest;
  final String? transactionId;
  final String? transactionPartnerId;
  final String? transactionPartnerIdOCR;
  final String? transactionPartnerIdOCRFront;
  final String? transactionPartnerIdLivenessFront;
  final String? transactionPartnerIdLivenessBack;
  final String? transactionPartnerIdCompareFace;
  final String? transactionPartnerIdLivenessFace;
  final String? transactionPartnerIdMaskedFace;

  // MARK: - CÁC THUỘC TÍNH VỀ CHỈNH SỬA TÊN CÁC TỆP TIN HIỆU ỨNG - VIDEO HƯỚNG DẪN
  final String? nameOvalAnimation;
  final String? nameFeedbackAnimation;
  final String? nameScanQRCodeAnimation;
  final String? namePreviewDocumentAnimation;
  final String? nameLoadSuccessAnimation;
  final String? nameHelpAudioFace;
  final String? nameHelpVideoFace;
  final String? nameHelpVideoDocument;

  // MARK: - CÁC THUỘC TÍNH VỀ MÀU SẮC GIAO DIỆN TRONG SDK
  final ModeButtonHeaderBar? modeButtonHeaderBar;
  final String? contentColorHeaderBar;
  final String? backgroundColorHeaderBar;
  final String? textColorContentMain;
  final String? titleColorMain;
  final String? backgroundColorMainScreen;
  final String? backgroundColorLine;
  final String? backgroundColorActiveButton;
  final String? backgroundColorDeactiveButton;
  final String? titleColorActiveButton;
  final String? titleColorDeactiveButton;
  final String? backgroundColorCaptureDocumentScreen;
  final String? backgroundColorCaptureFaceScreen;
  final String? effectColorNoticeFace;
  final String? textColorNoticeFace;
  final String? effectColorNoticeInvalidFace;
  final String? colorContentFaceEffect;
  final String? effectColorNoticeValidDocument;
  final String? effectColorNoticeInvalidDocument;
  final String? textColorNoticeValidDocument;
  final String? textColorNoticeInvalidDocument;
  final String? tintColorButtonCapture;
  final String? backgroundColorBorderCaptureFace;
  final bool? isShowLogo;
  final String? logo;
  final String? logoFaceOval;
  final String? widthLogo;
  final String? heightLogo;
  final String? imageTutorialQRCode;
  final String? imageTutorialFront;
  final String? imageTutorialBack;
  final String? imageTutorialBlur;
  final String? imageTutorialLostAngle;
  final String? imageTutorialGlare;
  final String? backgroundColorPopup;
  final String? textColorContentPopup;
  final bool? isEnableCheckVirtualCamera;
  final bool? isEnableCheckSimulator;
  final bool? isEnableCheckJailbroken;
  final bool? isAnimatedDismissed;

  const ICEkycConfig({
    this.accessToken,
    this.tokenId,
    this.tokenKey,
    this.versionSdk,
    this.flowType,
    this.languageSdk,
    this.challengeCode,
    this.inputClientSession,
    this.isShowTutorial,
    this.isDisableTutorial,
    this.isShowRequiredPermissionDecree,
    this.isEnableTutorialCardAdvance,
    this.isEnableGotIt,
    this.isShowSwitchCamera,
    this.cameraPositionForPortrait,
    this.zoomCamera,
    this.expiresTime,
    this.isTurnOffCallService,
    this.compressionQualityImage,
    this.isEnableAutoBrightness,
    this.screenBrightness,
    this.isSkipPreview,
    this.isEnableEncrypt,
    this.encryptPublicKey,
    this.modeUploadFile,
    this.documentType,
    this.hashFrontOcr,
    this.isCheckLivenessCard,
    this.isEnableScanQRCode,
    this.isShowQRCodeResult,
    this.validateDocumentType,
    this.isValidatePostcode,
    this.listBlockedDocument,
    this.modeVersionOCR,
    this.isEnableCompare,
    this.compareType,
    this.hashImageCompare,
    this.isCompareGeneral,
    this.thresLevel,
    this.checkLivenessFace,
    this.isCheckMaskedFace,
    this.isRecordVideoFace,
    this.isRecordVideoDocument,
    this.isEnableWaterMark,
    this.isAddMetadataImage,
    this.timeoutCallApi,
    this.changeBaseUrl,
    this.urlUploadImage,
    this.urlOcr,
    this.urlOcrFront,
    this.urlCompare,
    this.urlCompareGeneral,
    this.urlVerifyFace,
    this.urlAddFace,
    this.urlAddCardId,
    this.urlLivenessCard,
    this.urlCheckMaskedFace,
    this.urlSearchFace,
    this.urlLivenessFace,
    this.urlLivenessFace3D,
    this.urlLogSdk,
    this.headersRequest,
    this.transactionId,
    this.transactionPartnerId,
    this.transactionPartnerIdOCR,
    this.transactionPartnerIdOCRFront,
    this.transactionPartnerIdLivenessFront,
    this.transactionPartnerIdLivenessBack,
    this.transactionPartnerIdCompareFace,
    this.transactionPartnerIdLivenessFace,
    this.transactionPartnerIdMaskedFace,
    this.nameOvalAnimation,
    this.nameFeedbackAnimation,
    this.nameScanQRCodeAnimation,
    this.namePreviewDocumentAnimation,
    this.nameLoadSuccessAnimation,
    this.nameHelpAudioFace,
    this.nameHelpVideoFace,
    this.nameHelpVideoDocument,
    this.modeButtonHeaderBar,
    this.contentColorHeaderBar,
    this.backgroundColorHeaderBar,
    this.textColorContentMain,
    this.titleColorMain,
    this.backgroundColorMainScreen,
    this.backgroundColorLine,
    this.backgroundColorActiveButton,
    this.backgroundColorDeactiveButton,
    this.titleColorActiveButton,
    this.titleColorDeactiveButton,
    this.backgroundColorCaptureDocumentScreen,
    this.backgroundColorCaptureFaceScreen,
    this.effectColorNoticeFace,
    this.textColorNoticeFace,
    this.effectColorNoticeInvalidFace,
    this.colorContentFaceEffect,
    this.effectColorNoticeValidDocument,
    this.effectColorNoticeInvalidDocument,
    this.textColorNoticeValidDocument,
    this.textColorNoticeInvalidDocument,
    this.tintColorButtonCapture,
    this.backgroundColorBorderCaptureFace,
    this.isShowLogo,
    this.logo,
    this.logoFaceOval,
    this.widthLogo,
    this.heightLogo,
    this.imageTutorialQRCode,
    this.imageTutorialFront,
    this.imageTutorialBack,
    this.imageTutorialBlur,
    this.imageTutorialLostAngle,
    this.imageTutorialGlare,
    this.backgroundColorPopup,
    this.textColorContentPopup,
    this.isEnableCheckVirtualCamera,
    this.isEnableCheckSimulator,
    this.isEnableCheckJailbroken,
    this.isAnimatedDismissed,
  });

  /// Convert to Map for method channel
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = { };

    if (accessToken != null) map['access_token'] = accessToken!;
    if (tokenId != null) map['token_id'] = tokenId!;
    if (tokenKey != null) map['token_key'] = tokenKey!;
    if (versionSdk != null) map['version_sdk'] = versionSdk!.name;
    if (flowType != null) map['flow_type'] = flowType!.name;
    if (languageSdk != null) map['language_sdk'] = languageSdk!.name;
    if (challengeCode != null) map['challenge_code'] = challengeCode!;
    if (inputClientSession != null) map['input_client_session'] = inputClientSession!;
    if (isShowTutorial != null) map['is_show_tutorial'] = isShowTutorial!;
    if (isDisableTutorial != null) map['is_disable_tutorial'] = isDisableTutorial!;
    if (isShowRequiredPermissionDecree != null) map['is_show_required_permission_decree'] = isShowRequiredPermissionDecree!;
    if (isEnableTutorialCardAdvance != null) map['is_enable_tutorial_card_advance'] = isEnableTutorialCardAdvance!;
    if (isEnableGotIt != null) map['is_enable_gotit'] = isEnableGotIt!;
    if (isShowSwitchCamera != null) map['is_show_switch_camera'] = isShowSwitchCamera!;
    if (cameraPositionForPortrait != null) map['camera_position_for_portrait'] = cameraPositionForPortrait!.name;
    if (zoomCamera != null) map['zoom_camera'] = zoomCamera!;
    if (expiresTime != null) map['expires_time'] = expiresTime!;
    if (isTurnOffCallService != null) map['is_turn_off_call_service'] = isTurnOffCallService!;
    if (compressionQualityImage != null) map['compression_quality_image'] = compressionQualityImage!;
    if (isEnableAutoBrightness != null) map['is_enable_auto_brightness'] = isEnableAutoBrightness!;
    if (screenBrightness != null) map['screen_brightness'] = screenBrightness!;
    if (isSkipPreview != null) map['is_skip_preview'] = isSkipPreview!;
    if (isEnableEncrypt != null) map['is_enable_encrypt'] = isEnableEncrypt!;
    if (encryptPublicKey != null) map['encrypt_public_key'] = encryptPublicKey!;
    if (modeUploadFile != null) map['mode_upload_file'] = modeUploadFile!;
    if (documentType != null) map['document_type'] = documentType!.name;
    if (hashFrontOcr != null) map['hash_front_ocr'] = hashFrontOcr!;
    if (isCheckLivenessCard != null) map['is_check_liveness_card'] = isCheckLivenessCard!;
    if (isEnableScanQRCode != null) map['is_enable_scan_qrcode'] = isEnableScanQRCode!;
    if (isShowQRCodeResult != null) map['is_show_qrcode_result'] = isShowQRCodeResult!;
    if (validateDocumentType != null) map['validate_document_type'] = validateDocumentType!.name;
    if (isValidatePostcode != null) map['is_validate_postcode'] = isValidatePostcode!;
    if (listBlockedDocument != null) map['list_blocked_document'] = listBlockedDocument!;
    if (modeVersionOCR != null) map['mode_version_ocr'] = modeVersionOCR!;
    if (isEnableCompare != null) map['is_enable_compare'] = isEnableCompare!;
    if (compareType != null) map['compare_type'] = compareType!;
    if (hashImageCompare != null) map['hash_image_compare'] = hashImageCompare!;
    if (isCompareGeneral != null) map['is_compare_general'] = isCompareGeneral!;
    if (thresLevel != null) map['thres_level'] = thresLevel!;
    if (checkLivenessFace != null) map['check_liveness_face'] = checkLivenessFace!.name;
    if (isCheckMaskedFace != null) map['is_check_masked_face'] = isCheckMaskedFace!;
    if (isRecordVideoFace != null) map['is_record_video_face'] = isRecordVideoFace!;
    if (isRecordVideoDocument != null) map['is_record_video_document'] = isRecordVideoDocument!;
    if (isEnableWaterMark != null) map['is_enable_water_mark'] = isEnableWaterMark!;
    if (isAddMetadataImage != null) map['is_add_metadata_image'] = isAddMetadataImage!;
    if (timeoutCallApi != null) map['timeout_call_api'] = timeoutCallApi!;
    if (changeBaseUrl != null) map['change_base_url'] = changeBaseUrl!;
    if (urlUploadImage != null) map['url_upload_image'] = urlUploadImage!;
    if (urlOcr != null) map['url_ocr'] = urlOcr!;
    if (urlOcrFront != null) map['url_ocr_front'] = urlOcrFront!;
    if (urlCompare != null) map['url_compare'] = urlCompare!;
    if (urlCompareGeneral != null) map['url_compare_general'] = urlCompareGeneral!;
    if (urlVerifyFace != null) map['url_verify_face'] = urlVerifyFace!;
    if (urlAddFace != null) map['url_add_face'] = urlAddFace!;
    if (urlAddCardId != null) map['url_add_card_id'] = urlAddCardId!;
    if (urlLivenessCard != null) map['url_liveness_card'] = urlLivenessCard!;
    if (urlCheckMaskedFace != null) map['url_check_masked_face'] = urlCheckMaskedFace!;
    if (urlSearchFace != null) map['url_search_face'] = urlSearchFace!;
    if (urlLivenessFace != null) map['url_liveness_face'] = urlLivenessFace!;
    if (urlLivenessFace3D != null) map['url_liveness_face_3d'] = urlLivenessFace3D!;
    if (urlLogSdk != null) map['url_log_sdk'] = urlLogSdk!;
    if (headersRequest != null) map['headers_request'] = headersRequest!;
    if (transactionId != null) map['transaction_id'] = transactionId!;
    if (transactionPartnerId != null) map['transaction_partner_id'] = transactionPartnerId!;
    if (transactionPartnerIdOCR != null) map['transaction_partner_id_ocr'] = transactionPartnerIdOCR!;
    if (transactionPartnerIdOCRFront != null) map['transaction_partner_id_ocr_front'] = transactionPartnerIdOCRFront!;
    if (transactionPartnerIdLivenessFront != null) map['transaction_partner_id_liveness_front'] = transactionPartnerIdLivenessFront!;
    if (transactionPartnerIdLivenessBack != null) map['transaction_partner_id_liveness_back'] = transactionPartnerIdLivenessBack!;
    if (transactionPartnerIdCompareFace != null) map['transaction_partner_id_compare_face'] = transactionPartnerIdCompareFace!;
    if (transactionPartnerIdLivenessFace != null) map['transaction_partner_id_liveness_face'] = transactionPartnerIdLivenessFace!;
    if (transactionPartnerIdMaskedFace != null) map['transaction_partner_id_masked_face'] = transactionPartnerIdMaskedFace!;
    if (nameOvalAnimation != null) map['name_oval_animation'] = nameOvalAnimation!;
    if (nameFeedbackAnimation != null) map['name_feedback_animation'] = nameFeedbackAnimation!;
    if (nameScanQRCodeAnimation != null) map['name_scan_qrcode_animation'] = nameScanQRCodeAnimation!;
    if (namePreviewDocumentAnimation != null) map['name_preview_document_animation'] = namePreviewDocumentAnimation!;
    if (nameLoadSuccessAnimation != null) map['name_load_success_animation'] = nameLoadSuccessAnimation!;
    if (nameHelpAudioFace != null) map['name_help_audio_face'] = nameHelpAudioFace!;
    if (nameHelpVideoFace != null) map['name_help_video_face'] = nameHelpVideoFace!;
    if (nameHelpVideoDocument != null) map['name_help_video_document'] = nameHelpVideoDocument!;
    if (modeButtonHeaderBar != null) map['mode_button_header_bar'] = modeButtonHeaderBar!.name;
    if (contentColorHeaderBar != null) map['content_color_header_bar'] = contentColorHeaderBar!;
    if (backgroundColorHeaderBar != null) map['background_color_header_bar'] = backgroundColorHeaderBar!;
    if (textColorContentMain != null) map['text_color_content_main'] = textColorContentMain!;
    if (titleColorMain != null) map['title_color_main'] = titleColorMain!;
    if (backgroundColorMainScreen != null) map['background_color_main_screen'] = backgroundColorMainScreen!;
    if (backgroundColorLine != null) map['background_color_line'] = backgroundColorLine!;
    if (backgroundColorActiveButton != null) map['background_color_active_button'] = backgroundColorActiveButton!;
    if (backgroundColorDeactiveButton != null) map['background_color_deactive_button'] = backgroundColorDeactiveButton!;
    if (titleColorActiveButton != null) map['title_color_active_button'] = titleColorActiveButton!;
    if (titleColorDeactiveButton != null) map['title_color_deactive_button'] = titleColorDeactiveButton!;
    if (backgroundColorCaptureDocumentScreen != null) map['background_color_capture_document_screen'] = backgroundColorCaptureDocumentScreen!;
    if (backgroundColorCaptureFaceScreen != null) map['background_color_capture_face_screen'] = backgroundColorCaptureFaceScreen!;
    if (effectColorNoticeFace != null) map['effect_color_notice_face'] = effectColorNoticeFace!;
    if (textColorNoticeFace != null) map['text_color_notice_face'] = textColorNoticeFace!;
    if (effectColorNoticeInvalidFace != null) map['effect_color_notice_invalid_face'] = effectColorNoticeInvalidFace!;
    if (colorContentFaceEffect != null) map['color_content_face_effect'] = colorContentFaceEffect!;
    if (effectColorNoticeValidDocument != null) map['effect_color_notice_valid_document'] = effectColorNoticeValidDocument!;
    if (effectColorNoticeInvalidDocument != null) map['effect_color_notice_invalid_document'] = effectColorNoticeInvalidDocument!;
    if (textColorNoticeValidDocument != null) map['text_color_notice_valid_document'] = textColorNoticeValidDocument!;
    
    if (textColorNoticeInvalidDocument != null) map['text_color_notice_invalid_document'] = textColorNoticeInvalidDocument!;
    if (tintColorButtonCapture != null) map['tint_color_button_capture'] = tintColorButtonCapture!;
    if (backgroundColorBorderCaptureFace != null) map['background_color_border_capture_face'] = backgroundColorBorderCaptureFace!;
    if (isShowLogo != null) map['is_show_logo'] = isShowLogo!;
    if (logo != null) map['logo'] = logo!;
    if (logoFaceOval != null) map['logo_face_oval'] = logoFaceOval!;
    if (widthLogo != null) map['width_logo'] = widthLogo!;
    if (heightLogo != null) map['height_logo'] = heightLogo!;
    if (imageTutorialQRCode != null) map['image_tutorial_qrcode'] = imageTutorialQRCode!;
    if (imageTutorialFront != null) map['image_tutorial_front'] = imageTutorialFront!;
    if (imageTutorialBack != null) map['image_tutorial_back'] = imageTutorialBack!;
    if (imageTutorialBlur != null) map['image_tutorial_blur'] = imageTutorialBlur!;
    if (imageTutorialLostAngle != null) map['image_tutorial_lost_angle'] = imageTutorialLostAngle!;
    if (imageTutorialGlare != null) map['image_tutorial_glare'] = imageTutorialGlare!;
    if (backgroundColorPopup != null) map['background_color_popup'] = backgroundColorPopup!;
    if (textColorContentPopup != null) map['text_color_content_popup'] = textColorContentPopup!;
    if (isEnableCheckVirtualCamera != null) map['is_enable_check_virtual_camera'] = isEnableCheckVirtualCamera!;
    if (isEnableCheckSimulator != null) map['is_enable_check_simulator'] = isEnableCheckSimulator!;
    if (isEnableCheckJailbroken != null) map['is_enable_check_jailbroken'] = isEnableCheckJailbroken!;
    if (isAnimatedDismissed != null) map['is_animated_dismissed'] = isAnimatedDismissed!;
    return map;
  }
}

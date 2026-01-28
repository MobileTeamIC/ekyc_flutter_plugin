class ICEkycKeyResult {
  static const String cropParam = "CROP_PARAM";
  static const String pathImageFrontFull = "PATH_IMAGE_FRONT_FULL";
  static const String pathImageBackFull = "PATH_IMAGE_BACK_FULL";
  static const String pathImageFaceFull = "PATH_IMAGE_FACE_FULL";
  static const String pathImageFaceFarFull = "PATH_IMAGE_FACE_FAR_FULL";
  static const String pathImageFaceNearFull = "PATH_IMAGE_FACE_NEAR_FULL";
  static const String pathImageFaceScan3D = "PATH_FACE_SCAN3D";
  static const String clientSessionResult = "CLIENT_SESSION_RESULT";

  // Dữ liệu việc QUÉT mã QR
  static const String qrCodeResult = "QR_CODE_RESULT";

  // Đường dẫn ảnh qr code full
  static const String pathImageQRCodeFull = "PATH_IMAGE_QR_CODE_FULL";

  // Dữ liệu việc QUÉT mã QR [StringJson]
  static const String qrCodeResultDetail = "QR_CODE_RESULT_DETAIL";

  // Dữ liệu lỗi khi thực hiện retry scan QR [StringJson]
  static const String retryQRCodeResult = "RETRY_QR_CODE_RESULT";
}
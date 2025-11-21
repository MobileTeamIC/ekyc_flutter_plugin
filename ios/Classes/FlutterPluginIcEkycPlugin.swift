import Flutter
import UIKit
import ICSdkEKYC

public class FlutterPluginIcEkycPlugin: NSObject, FlutterPlugin {

 // Store the result callback for SDK delegate methods
  private var pendingResult: FlutterResult?
  private var flutterViewController: UIViewController? {
    // Find the key window's root view controller
    var keyWindow: UIWindow?
    if #available(iOS 13.0, *) {
      keyWindow = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    } else {
      keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
     
    guard let window = keyWindow,
          var topController = window.rootViewController else {
      return nil
    }
    
    while let presentedViewController = topController.presentedViewController {
      topController = presentedViewController
    }
    return topController
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter.sdk.ic_ekyc/integrate", binaryMessenger: registrar.messenger())
    let instance = FlutterPluginIcEkycPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    pendingResult = result
    
    guard let args = call.arguments as? [String: Any] else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
      return
    }
    
    guard let controller = flutterViewController else {
      result(FlutterError(code: "NO_VIEW_CONTROLLER", message: "No view controller available", details: nil))
      return
    }
    
    switch call.method {
      case "startEkycFull":
          self.startEkycFull(controller, args: args)
      case "startEkycOcr":
          self.startEkycOcr(controller, args: args)
      case "startEkycOcrFront":
          self.startEkycOcrFront(controller, args: args)
      case "startEkycOcrBack":
          self.startEkycOcrBack(controller, args: args)
      case "startEkycFace":
          self.startEkycFace(controller, args: args)
      case "startEkycScanQRCode":
          self.startEkycScanQRCode(controller, args: args)
      default:
          result(FlutterMethodNotImplemented)
    }
  }

   //MARK: - Full
    /// Luồng đầy đủ: OCR + Face Verification
    /// 
    /// Thực hiện eKYC đầy đủ các bước: chụp giấy tờ và chụp ảnh chân dung
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
    ///   - flow_type: Loại luồng thực hiện ("full", "none", "scanqr", "ocrfront", "ocrback", "ocr", "face")
    ///   - version_sdk: Phiên bản SDK cho chụp ảnh chân dung ("normal", "prooval")
    ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_enable_compare: Bật/tắt chức năng so sánh ảnh chân dung ("true"/"false")
    ///   - is_check_masked_face: Bật/tắt chức năng kiểm tra che mặt ("true"/"false")
    ///   - check_liveness_face: Chức năng kiểm tra ảnh chân dung chụp trực tiếp ("nonecheckface", "ibeta", "standard")
    ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
    ///   - is_validate_postcode: Bật/tắt chức năng kiểm tra mã bưu điện ("true"/"false")
    ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
    ///   - change_base_url: Đường dẫn API tùy chỉnh
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    func startEkycFull(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController

        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let versionSdk = (args[KeyArgumentMethod.versionSdk] as? String) ?? ""
        let documentType = (args[KeyArgumentMethod.documentType] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let isEnableCompare = (args[KeyArgumentMethod.isEnableCompare] as? Bool) ?? false
        let isCheckMaskedFace = (args[KeyArgumentMethod.isCheckMaskedFace] as? Bool) ?? false
        let checkLivenessFace = (args[KeyArgumentMethod.checkLivenessFace] as? String) ?? ""
        let isCheckLivenessCard = (args[KeyArgumentMethod.isCheckLivenessCard] as? Bool) ?? false
        let isValidatePostcode = (args[KeyArgumentMethod.isValidatePostcode] as? Bool) ?? false
        let validateDocumentType = (args[KeyArgumentMethod.validateDocumentType] as? String) ?? ""
        let changeBaseUrl = (args[KeyArgumentMethod.changeBaseUrl] as? String) ?? ""
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? true

        ICEkycCamera.cameraDelegate = self
        ICEkycCamera.flowType = full
        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.versionSdk = convertToVersionSdk(versionSdk)
        ICEkycCamera.documentType = convertToDocumentType(documentType)
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.isEnableCompare = isEnableCompare
        ICEkycCamera.isCheckMaskedFace = isCheckMaskedFace
        ICEkycCamera.checkLivenessFace = convertToLivenessFaceMode(checkLivenessFace)
        ICEkycCamera.isCheckLivenessCard = isCheckLivenessCard
        ICEkycCamera.isValidatePostcode = isValidatePostcode
        ICEkycCamera.validateDocumentType = convertToValidateDocumentType(validateDocumentType)
        ICEkycCamera.changeBaseUrl = changeBaseUrl
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.isShowLogo = isShowLogo
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        
        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
    }
    
    //MARK: - OCR
    /// Luồng chỉ thực hiện đọc giấy tờ: OCR
    /// 
    /// Thực hiện OCR giấy tờ (cả mặt trước và mặt sau)
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
    ///   - flow_type: Loại luồng thực hiện ("ocr", "none", "scanqr", "ocrfront", "ocrback", "full", "face")
    ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
    ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
    ///   - is_validate_postcode: Bật/tắt chức năng kiểm tra mã bưu điện ("true"/"false")
    ///   - change_base_url: Đường dẫn API tùy chỉnh
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    func startEkycOcr(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController

        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let documentType = (args[KeyArgumentMethod.documentType] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let isCheckLivenessCard = (args[KeyArgumentMethod.isCheckLivenessCard] as? Bool) ?? false
        let validateDocumentType = (args[KeyArgumentMethod.validateDocumentType] as? String) ?? ""
        let changeBaseUrl = (args[KeyArgumentMethod.changeBaseUrl] as? String) ?? ""
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let isValidatePostcode = (args[KeyArgumentMethod.isValidatePostcode] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? true
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false
        ICEkycCamera.cameraDelegate = self
        
        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.documentType = convertToDocumentType(documentType)
        ICEkycCamera.flowType = ocr
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.isValidatePostcode = isValidatePostcode
        ICEkycCamera.isCheckLivenessCard = isCheckLivenessCard
        ICEkycCamera.validateDocumentType = convertToValidateDocumentType(validateDocumentType)
        ICEkycCamera.changeBaseUrl = changeBaseUrl
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.isShowLogo = isShowLogo
        
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService
        
        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
        
    }
    
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
    func startEkycOcrFront(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController

        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let documentType = (args[KeyArgumentMethod.documentType] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let isCheckLivenessCard = (args[KeyArgumentMethod.isCheckLivenessCard] as? Bool) ?? false
        let validateDocumentType = (args[KeyArgumentMethod.validateDocumentType] as? String) ?? ""
        let changeBaseUrl = (args[KeyArgumentMethod.changeBaseUrl] as? String) ?? ""
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let isValidatePostcode = (args[KeyArgumentMethod.isValidatePostcode] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? true
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false
        
        ICEkycCamera.cameraDelegate = self
        ICEkycCamera.flowType = ocrFront
        
        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.documentType = convertToDocumentType(documentType)
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.isValidatePostcode = isValidatePostcode
        ICEkycCamera.isCheckLivenessCard = isCheckLivenessCard
        ICEkycCamera.validateDocumentType = convertToValidateDocumentType(validateDocumentType)
        ICEkycCamera.changeBaseUrl = changeBaseUrl
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.isShowLogo = isShowLogo
        
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService
        
        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
        
    }
    
    //MARK: - ORC BACK
    /// Luồng chỉ thực hiện đọc giấy tờ chỉ mặt sau: OCR Back
    /// 
    /// Thực hiện OCR giấy tờ một bước: chụp mặt sau giấy tờ
    /// 
    /// - Parameters:
    ///   - controller: Root view controller để present eKYC SDK
    ///   - info: Dictionary chứa các thông số cấu hình eKYC
    ///
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
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
    func startEkycOcrBack(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
        
        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let documentType = (args[KeyArgumentMethod.documentType] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let hashFrontOCR = (args[KeyArgumentMethod.hashFrontOCR] as? String) ?? ""
        let isCheckLivenessCard = (args[KeyArgumentMethod.isCheckLivenessCard] as? Bool) ?? false
        let validateDocumentType = (args[KeyArgumentMethod.validateDocumentType] as? String) ?? ""
        let changeBaseUrl = (args[KeyArgumentMethod.changeBaseUrl] as? String) ?? ""
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let isValidatePostcode = (args[KeyArgumentMethod.isValidatePostcode] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? true
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false
        ICEkycCamera.cameraDelegate = self
        ICEkycCamera.flowType = ocrBack
        
        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.documentType = convertToDocumentType(documentType)
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.hashFrontOCR = hashFrontOCR
        ICEkycCamera.isValidatePostcode = isValidatePostcode
        ICEkycCamera.isCheckLivenessCard = isCheckLivenessCard
        ICEkycCamera.validateDocumentType = convertToValidateDocumentType(validateDocumentType)
        ICEkycCamera.changeBaseUrl = changeBaseUrl
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.isShowLogo = isShowLogo

        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService
        
        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
        
    }
    
    //MARK: - FACE
    /// Luồng chỉ thực hiện xác thực khuôn mặt: Face Verification
    /// 
    /// Thực hiện chụp ảnh Oval xa gần và thực hiện các chức năng tùy vào cấu hình: Compare, Verify, Mask, Liveness Face
    /// 
    /// - Parameters:
    ///   - controller: Root view controller để present eKYC SDK
    ///   - info: Dictionary chứa các thông số cấu hình eKYC
    ///
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
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
    func startEkycFace(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
        
        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let versionSdk = (args[KeyArgumentMethod.versionSdk] as? String) ?? ""
        let hashImageCompare = (args[KeyArgumentMethod.hashImageCompare] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let isEnableCompare = (args[KeyArgumentMethod.isEnableCompare] as? Bool) ?? false
        let isCheckMaskedFace = (args[KeyArgumentMethod.isCheckMaskedFace] as? Bool) ?? false
        let checkLivenessFace = (args[KeyArgumentMethod.checkLivenessFace] as? String) ?? ""
        let changeBaseUrl = (args[KeyArgumentMethod.changeBaseUrl] as? String) ?? ""
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? false
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false
        ICEkycCamera.cameraDelegate = self
        ICEkycCamera.flowType = face


        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.versionSdk = convertToVersionSdk(versionSdk)
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.isEnableCompare = isEnableCompare
        ICEkycCamera.hashImageCompare = hashImageCompare
        ICEkycCamera.isCheckMaskedFace = isCheckMaskedFace
        ICEkycCamera.checkLivenessFace = convertToLivenessFaceMode(checkLivenessFace)
        ICEkycCamera.changeBaseUrl = changeBaseUrl
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.isShowLogo = isShowLogo

        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService
        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
    }

    //MARK: - SCANQR CODE
    /// Luồng chỉ thực hiện quét QR code: Scan QR Code
    /// 
    /// Thực hiện quét QR code để lấy thông tin từ QR code
    /// 
    /// - Parameters:
    ///   - controller: Root view controller để present eKYC SDK
    ///   - info: Dictionary chứa các thông số cấu hình eKYC
    ///
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    func startEkycScanQRCode(_ controller: UIViewController, args: [String: Any]) {
        let ICEkycCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
        
        let accessToken = (args[KeyArgumentMethod.accessToken] as? String) ?? ""
        let tokenId = (args[KeyArgumentMethod.tokenId] as? String) ?? ""
        let tokenKey = (args[KeyArgumentMethod.tokenKey] as? String) ?? ""
        let isShowTutorial = (args[KeyArgumentMethod.isShowTutorial] as? Bool) ?? false
        let isEnableGotIt = (args[KeyArgumentMethod.isEnableGotIt] as? Bool) ?? false
        let languageSdk = (args[KeyArgumentMethod.languageSdk] as? String) ?? ""
        let isShowLogo = (args[KeyArgumentMethod.isShowLogo] as? Bool) ?? false
        let isTurnOffCallService = (args[KeyArgumentMethod.isTurnOffCallService] as? Bool) ?? true
        let challengeCode = (args[KeyArgumentMethod.challengeCode] as? String) ?? ""
        let isEnableScanQRCode = (args[KeyArgumentMethod.isEnableScanQRCode] as? Bool) ?? false

        ICEkycCamera.cameraDelegate = self
        ICEkycCamera.flowType = scanQR

        ICEkycCamera.accessToken = accessToken
        ICEkycCamera.tokenId = tokenId
        ICEkycCamera.tokenKey = tokenKey
        ICEkycCamera.isShowTutorial = isShowTutorial
        ICEkycCamera.isEnableGotIt = isEnableGotIt
        ICEkycCamera.isShowLogo = isShowLogo

        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.challengeCode = challengeCode
        ICEkycCamera.languageSdk = convertLanguageSdk(languageSdk)
        ICEkycCamera.cameraPositionForPortrait = PositionFront
        ICEkycCamera.isEnableScanQRCode = isEnableScanQRCode
        ICEkycCamera.isTurnOffCallService = isTurnOffCallService

        DispatchQueue.main.async {
            ICEkycCamera.modalTransitionStyle = .coverVertical
            ICEkycCamera.modalPresentationStyle = .fullScreen
            controller.present(ICEkycCamera, animated: true)
        }
    }
  
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // MARK: - Conversion Methods
    
    /// Convert string to VersionSdk enum
    private func convertToVersionSdk(_ value: String?) -> VersionSdk {
        guard let value = value?.lowercased() else { return Normal }
        
        switch value {
        case "normal":
            return Normal
        case "prooval":
            return ProOval
        default:
            return Normal
        }
    }
    
    /// Convert string to TypeDocument enum
    private func convertToDocumentType(_ value: String?) -> TypeDocument {
        guard let value = value?.lowercased() else { return IdentityCard }
        
        switch value {
        case "identitycard":
            return IdentityCard
        case "idcardchipbased":
            return IDCardChipBased
        case "passport":
            return Passport
        case "driverlicense":
            return DriverLicense
        case "militaryidcard":
            return MilitaryIdCard
        default:
            return IdentityCard
        }
    }
    
    /// Convert string to ModeCheckLivenessFace enum
    private func convertToLivenessFaceMode(_ value: String?) -> ModeCheckLivenessFace {
        guard let value = value?.lowercased() else { return NoneCheckFace }
        
        switch value {
        case "nonecheckface":
            return NoneCheckFace
        case "ibeta":
            return IBeta
        case "standard":
            return Standard
        default:
            return NoneCheckFace
        }
    }
    
    /// Convert string to TypeValidateDocument enum
    private func convertToValidateDocumentType(_ value: String?) -> TypeValidateDocument {
        guard let value = value?.lowercased() else { return Basic }
        
        switch value {
        case "none":
            return None
        case "basic":
            return Basic
        case "medium":
            return Medium
        case "advance":
            return Advance
        default:
            return Basic
        }
    }
    
    private func convertLanguageSdk(_ value: String?) -> String {
        guard let value = value?.lowercased() else { return "icekyc_vi" }

        switch value {
        case "icekyc_vi":
            return "icekyc_vi"
        case "icekyc_en":
            return "icekyc_en"
        default:
            return "icekyc_vi"
        }
    }

}

extension FlutterPluginIcEkycPlugin: ICEkycCameraDelegate {
    
    public func icEkycGetResult() {
        UIDevice.current.isProximityMonitoringEnabled = false /// tắt cảm biến làm tối màn hình
        let cropParam = ICEKYCSavedData.shared().cropParam;
        let pathImageFrontFull = ICEKYCSavedData.shared().pathImageFrontFull;
        let pathImageBackFull = ICEKYCSavedData.shared().pathImageBackFull;
        let pathImageFaceFull = ICEKYCSavedData.shared().pathImageFaceFull;
        let pathImageFaceFarFull = ICEKYCSavedData.shared().pathImageFaceFarFull;
        let pathImageFaceNearFull = ICEKYCSavedData.shared().pathImageFaceNearFull;
        let dataScan3D = ICEKYCSavedData.shared().dataScan3D;
        // save file
        let pathFaceScan3D = saveDataToDocuments(data: dataScan3D, fileName: "3dScanPortrait", fileExtension: "txt")
        let clientSessionResult = ICEKYCSavedData.shared().clientSessionResult;
        
        let dict: [String: Any] = [
            KeyResultConstantsEKYC.cropParam: cropParam,
            KeyResultConstantsEKYC.pathImageFrontFull: pathImageFrontFull.path,
            KeyResultConstantsEKYC.pathImageBackFull: pathImageBackFull.path,
            KeyResultConstantsEKYC.pathImageFaceFull: pathImageFaceFull.path ,
            KeyResultConstantsEKYC.pathImageFaceFarFull: pathImageFaceFarFull.path,
            KeyResultConstantsEKYC.pathImageFaceNearFull: pathImageFaceNearFull.path,
            KeyResultConstantsEKYC.pathImageFaceScan3D: pathFaceScan3D?.path ?? "",
            KeyResultConstantsEKYC.clientSessionResult: clientSessionResult
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            pendingResult?(jsonString)
            pendingResult = nil
            
        } catch {
            print(error.localizedDescription)
            pendingResult?(FlutterError(code: "JSON_ERROR", message: error.localizedDescription, details: nil))
            pendingResult = nil
        }
      
    }
    
    public func icEkycCameraClosed(with type: ScreenType) {
        UIDevice.current.isProximityMonitoringEnabled = false
        pendingResult?(FlutterError(code: "CANCELLED", message: "User cancelled eKYC flow", details: nil))
        pendingResult = nil
    }
    
}
extension FlutterPluginIcEkycPlugin {
    /// Hàm lưu Data vào thư mục Documents
    /// - Parameters:
    ///   - data: Dữ liệu cần lưu (tương đương NSData)
    ///   - fileName: Tên file (không bao gồm đuôi file)
    ///   - fileExtension: Đuôi file (ví dụ: "obj", "stl", "dat")
    /// - Returns: URL tới file đã lưu nếu thành công, trả về nil nếu thất bại
    func saveDataToDocuments(data: Data, fileName: String, fileExtension: String) -> URL? {
        
        // 1. Lấy đường dẫn thư mục Documents
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            debugPrint("[eKYC IC] Không tìm thấy thư mục Documents")
            return nil
        }
        
        // 2. Tạo URL đầy đủ cho file
        let fileURL = documentsDirectory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        // 3. Ghi dữ liệu vào file
        do {
            // options: .atomic đảm bảo file được ghi toàn vẹn hoặc không ghi gì cả (tránh lỗi corrupt file)
            try data.write(to: fileURL, options: .atomic)
            debugPrint("[eKYC IC] Lưu file thành công")
            return fileURL
        } catch {
            debugPrint("[eKYC IC] Lỗi khi lưu data 3D: \(error.localizedDescription)")
            return nil
        }
    }
}


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
            let errorResponse: [String: Any] = [
                "status": EKYCStatus.failed,
                "data": [
                    "code": "INVALID_ARGUMENTS",
                    "message": "Invalid arguments"
                ]
            ]
            sendJsonResult(errorResponse)
            return
        }
        
        guard let controller = flutterViewController else {
            let errorResponse: [String: Any] = [
                "status": EKYCStatus.failed,
                "data": [
                    "code": "NO_VIEW_CONTROLLER",
                    "message": "No view controller available"
                ]
            ]
            sendJsonResult(errorResponse)
            return
        }
        
        switch call.method {
        case "startEkycFull":
            self.startEkyc(controller, flowType: full, args: args)
        case "startEkycOcr":
            self.startEkyc(controller, flowType: ocr, args: args)
        case "startEkycOcrFront":
            self.startEkyc(controller, flowType: ocrFront, args: args)
        case "startEkycOcrBack":
            self.startEkyc(controller, flowType: ocrBack, args: args)
        case "startEkycFace":
            self.startEkyc(controller, flowType: face, args: args)
        case "startEkycScanQRCode":
            self.startEkyc(controller, flowType: scanQR, args: args)
        default:
            let errorResponse: [String: Any] = [
                "status": EKYCStatus.failed,
                "data": [
                    "code": "METHOD_NOT_IMPLEMENTED",
                    "message": "Method \(call.method) is not implemented"
                ]
            ]
            sendJsonResult(errorResponse)
        }
    }
    
    func startEkyc(_ controller: UIViewController, flowType: FlowType,  args: [String: Any]) {
        let ekycVC = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
   
        ekycVC.cameraDelegate = self
        
        ekycVC.flowType = flowType
        
        configureGeneral(for: ekycVC, with: args)
        configureDocumentOptions(for: ekycVC, args: args)
        configureFaceOptions(for: ekycVC, args: args)
        configureVideoOptions(for: ekycVC, args: args)
        configureEnvironmentOptions(for: ekycVC, args: args)
        configureAnimationOptions(for: ekycVC, args: args)
        configureUICommonOptions(for: ekycVC, args: args)
        
        DispatchQueue.main.async {
            ekycVC.modalTransitionStyle = .coverVertical
            ekycVC.modalPresentationStyle = .fullScreen
            controller.present(ekycVC, animated: true)
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
    
    
    
    
}

// MARK: - Conversion Methods
extension FlutterPluginIcEkycPlugin {
    /// Convert string to modeButtonHeaderBar enum
    private func convertToModeButtonHeaderBar(_ value: String?) -> ModeButtonHeaderBar {
        switch value {
        case "leftButton":
            return LeftButton
        case "rightButton":
            return RightButton
        default:
            return LeftButton
        }
    }
    
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


//MARK: Helper
extension FlutterPluginIcEkycPlugin {
    
    private func configureGeneral(for ekycVC: ICEkycCameraViewController, with args: [String: Any]) {
        
        ekycVC.accessToken = args[KeyArgumentMethod.accessToken] as? String ?? ""
        ekycVC.tokenId = args[KeyArgumentMethod.tokenId] as? String ?? ""
        ekycVC.tokenKey = args[KeyArgumentMethod.tokenKey] as? String ?? ""
        ekycVC.changeBaseUrl = args[KeyArgumentMethod.changeBaseUrl] as? String ?? ""
        ekycVC.versionSdk = convertToVersionSdk(args[KeyArgumentMethod.versionSdk] as? String ?? "")
        //       ekycVC.flowType = convertToFlowType(args[KeyArgumentMethod.flowType] as? String ?? "")
        ekycVC.languageSdk = convertLanguageSdk(args[KeyArgumentMethod.languageSdk] as? String ?? "")
        ekycVC.challengeCode = args[KeyArgumentMethod.challengeCode] as? String ?? ""
        ekycVC.inputClientSession = args[KeyArgumentMethod.inputClientSession] as? String ?? ""
        ekycVC.isShowTutorial = args[KeyArgumentMethod.isShowTutorial] as? Bool ?? false
        ekycVC.isDisableTutorial = args[KeyArgumentMethod.isDisableTutorial] as? Bool ?? false
        ekycVC.isShowRequiredPermissionDecree = args[KeyArgumentMethod.isShowRequiredPermissionDecree] as? Bool ?? false
        ekycVC.isEnableTutorialCardAdvance = args[KeyArgumentMethod.isEnableTutorialCardAdvance] as? Bool ?? false
        //       ekycVC.modelHelpFace =
        ekycVC.isEnableGotIt = args[KeyArgumentMethod.isEnableGotIt] as? Bool ?? false
        ekycVC.isShowSwitchCamera = args[KeyArgumentMethod.isShowSwitchCamera] as? Bool ?? false
        ekycVC.cameraPositionForPortrait = PositionFront
        ekycVC.zoomCamera = args[KeyArgumentMethod.zoomCamera] as? Double ?? 0.0
        ekycVC.expiresTime = args[KeyArgumentMethod.expiresTime] as? Int ?? 0
        ekycVC.isTurnOffCallService = args[KeyArgumentMethod.isTurnOffCallService] as? Bool ?? false
        ekycVC.compressionQualityImage = args[KeyArgumentMethod.compressionQualityImage] as? Double ?? 0.0
        ekycVC.isEnableAutoBrightness = args[KeyArgumentMethod.isEnableAutoBrightness] as? Bool ?? false
        ekycVC.screenBrightness = args[KeyArgumentMethod.screenBrightness] as? Double ?? 0.0
        ekycVC.isSkipPreview = args[KeyArgumentMethod.isSkipPreview] as? Bool ?? false
        ekycVC.isEnableEncrypt = args[KeyArgumentMethod.isEnableEncrypt] as? Bool ?? false
        ekycVC.encryptPublicKey = args[KeyArgumentMethod.encryptPublicKey] as? String ?? ""
        //       ekycVC.modeUploadFile = args[KeyArgumentMethod.modeUploadFile] as? String ?? ""
    }
    
    private func configureDocumentOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
        ekycVC.documentType = convertToDocumentType(args[KeyArgumentMethod.documentType] as? String ?? "")
        ekycVC.hashFrontOCR = args[KeyArgumentMethod.hashFrontOCR] as? String ?? ""
        ekycVC.isCheckLivenessCard = args[KeyArgumentMethod.isCheckLivenessCard] as? Bool ?? false
        ekycVC.isEnableScanQRCode = args[KeyArgumentMethod.isEnableScanQRCode] as? Bool ?? false
        ekycVC.isShowQRCodeResult = args[KeyArgumentMethod.isShowQRCodeResult] as? Bool ?? false
        ekycVC.validateDocumentType = convertToValidateDocumentType(args[KeyArgumentMethod.validateDocumentType] as? String ?? "")
        ekycVC.isValidatePostcode = args[KeyArgumentMethod.isValidatePostcode] as? Bool ?? false
        //        ekycVC.listBlockedDocument = args[KeyArgumentMethod.listBlockedDocument] as? [String] ?? []
        //        ekycVC.modeVersionOCR = convertToModeVersionOCR(args[KeyArgumentMethod.modeVersionOCR] as? String ?? "")
    }
    
    //   CÁC THUỘC TÍNH VỀ KHUÔN MẶT
    private func configureFaceOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
//        ekycVC.modeVersionFaceOval = convertToModeVersionFaceOval(args[KeyArgumentMethod.modeVersionFaceOval] as? String ?? "")
        ekycVC.isEnableCompare = args[KeyArgumentMethod.isEnableCompare] as? Bool ?? false
        ekycVC.compareType = args[KeyArgumentMethod.compareType] as? Int ?? 0
        ekycVC.hashImageCompare = args[KeyArgumentMethod.hashImageCompare] as? String ?? ""
        ekycVC.isCompareGeneral = args[KeyArgumentMethod.isCompareGeneral] as? Bool ?? false
//        ekycVC.thresLevel = args[KeyArgumentMethod.thresLevel] as? Double ?? 0.0
        ekycVC.checkLivenessFace = convertToLivenessFaceMode(args[KeyArgumentMethod.checkLivenessFace] as? String ?? "")
        ekycVC.isCheckMaskedFace = args[KeyArgumentMethod.isCheckMaskedFace] as? Bool ?? false
    }
    
    // CÁC THUỘC TÍNH VỀ VIỆC QUAY VIDEO LẠI QUÁ TRÌNH THỰC HIỆN OCR VÀ FACE TRONG SDK
    private func configureVideoOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
        ekycVC.isRecordVideoFace = args[KeyArgumentMethod.isRecordVideoFace] as? Bool ?? false
        ekycVC.isRecordVideoDocument = args[KeyArgumentMethod.isRecordVideoDocument] as? Bool ?? false
    }
    
    // CÁC THUỘC TÍNH VỀ MÔI TRƯỜNG PHÁT TRIỂN - URL TÁC VỤ TRONG SDK
    private func configureEnvironmentOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
        ekycVC.isEnableWaterMark = args[KeyArgumentMethod.isEnableWaterMark] as? Bool ?? false
        ekycVC.isAddMetadataImage = args[KeyArgumentMethod.isAddMetadataImage] as? Bool ?? false
        ekycVC.timeoutCallApi = args[KeyArgumentMethod.timeoutCallApi] as? Int ?? 0
        ekycVC.changeBaseUrl = args[KeyArgumentMethod.changeBaseUrl] as? String ?? ""
        ekycVC.urlUploadImage = args[KeyArgumentMethod.urlUploadImage] as? String ?? ""
        ekycVC.urlOcr = args[KeyArgumentMethod.urlOcr] as? String ?? ""
        ekycVC.urlOcrFront = args[KeyArgumentMethod.urlOcrFront] as? String ?? ""
        ekycVC.urlCompare = args[KeyArgumentMethod.urlCompare] as? String ?? ""
        ekycVC.urlCompareGeneral = args[KeyArgumentMethod.urlCompareGeneral] as? String ?? ""
        ekycVC.urlVerifyFace = args[KeyArgumentMethod.urlVerifyFace] as? String ?? ""
        ekycVC.urlAddFace = args[KeyArgumentMethod.urlAddFace] as? String ?? ""
        ekycVC.urlAddCardId = args[KeyArgumentMethod.urlAddCardId] as? String ?? ""
        ekycVC.urlLivenessCard = args[KeyArgumentMethod.urlLivenessCard] as? String ?? ""
        ekycVC.urlCheckMaskedFace = args[KeyArgumentMethod.urlCheckMaskedFace] as? String ?? ""
        ekycVC.urlSearchFace = args[KeyArgumentMethod.urlSearchFace] as? String ?? ""
        ekycVC.urlLivenessFace = args[KeyArgumentMethod.urlLivenessFace] as? String ?? ""
        ekycVC.urlLivenessFace3D = args[KeyArgumentMethod.urlLivenessFace3D] as? String ?? ""
        ekycVC.urlLogSdk = args[KeyArgumentMethod.urlLogSdk] as? String ?? ""
//        ekycVC.headersRequest = args[KeyArgumentMethod.headersRequest] as? [String: Any] ?? [:]
        ekycVC.transactionId = args[KeyArgumentMethod.transactionId] as? String ?? ""
        ekycVC.transactionPartnerId = args[KeyArgumentMethod.transactionPartnerId] as? String ?? ""
        ekycVC.transactionPartnerIdOCR = args[KeyArgumentMethod.transactionPartnerIdOCR] as? String ?? ""
        ekycVC.transactionPartnerIdOCRFront = args[KeyArgumentMethod.transactionPartnerIdOCRFront] as? String ?? ""
        ekycVC.transactionPartnerIdLivenessFront = args[KeyArgumentMethod.transactionPartnerIdLivenessFront] as? String ?? ""
        ekycVC.transactionPartnerIdLivenessBack = args[KeyArgumentMethod.transactionPartnerIdLivenessBack] as? String ?? ""
        ekycVC.transactionPartnerIdCompareFace = args[KeyArgumentMethod.transactionPartnerIdCompareFace] as? String ?? ""
        ekycVC.transactionPartnerIdLivenessFace = args[KeyArgumentMethod.transactionPartnerIdLivenessFace] as? String ?? ""
        ekycVC.transactionPartnerIdMaskedFace = args[KeyArgumentMethod.transactionPartnerIdMaskedFace] as? String ?? ""
    }
    
    // CÁC THUỘC TÍNH VỀ CHỈNH SỬA TÊN CÁC TỆP TIN HIỆU ỨNG - VIDEO HƯỚNG DẪN
    private func configureAnimationOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
        ekycVC.nameOvalAnimation = args[KeyArgumentMethod.nameOvalAnimation] as? String ?? ""
        ekycVC.nameFeedbackAnimation = args[KeyArgumentMethod.nameFeedbackAnimation] as? String ?? ""
        ekycVC.nameScanQRCodeAnimation = args[KeyArgumentMethod.nameScanQRCodeAnimation] as? String ?? ""
        ekycVC.namePreviewDocumentAnimation = args[KeyArgumentMethod.namePreviewDocumentAnimation] as? String ?? ""
        ekycVC.nameLoadSuccessAnimation = args[KeyArgumentMethod.nameLoadSuccessAnimation] as? String ?? ""
    }
    
    // CÁC THUỘC TÍNH VỀ MÀU SẮC GIAO DIỆN TRONG SDK
    private func configureUICommonOptions(for ekycVC: ICEkycCameraViewController, args: [String: Any]) {
        ekycVC.modeButtonHeaderBar = convertToModeButtonHeaderBar(args[KeyArgumentMethod.modeButtonHeaderBar] as? String ?? "")
//        ekycVC.contentColorHeaderBar = args[KeyArgumentMethod.contentColorHeaderBar] as? String ?? ""
//        ekycVC.backgroundColorHeaderBar = args[KeyArgumentMethod.backgroundColorHeaderBar] as? String ?? ""
//        ekycVC.textColorContentMain = args[KeyArgumentMethod.textColorContentMain] as? String ?? ""
//        ekycVC.titleColorMain = args[KeyArgumentMethod.titleColorMain] as? String ?? ""
//        ekycVC.backgroundColorMainScreen = args[KeyArgumentMethod.backgroundColorMainScreen] as? String ?? ""
//        ekycVC.backgroundColorLine = args[KeyArgumentMethod.backgroundColorLine] as? String ?? ""
//        ekycVC.backgroundColorActiveButton = args[KeyArgumentMethod.backgroundColorActiveButton] as? String ?? ""
//        ekycVC.backgroundColorDeactiveButton = args[KeyArgumentMethod.backgroundColorDeactiveButton] as? String ?? ""
//        ekycVC.titleColorActiveButton = args[KeyArgumentMethod.titleColorActiveButton] as? String ?? ""
//        ekycVC.titleColorDeactiveButton = args[KeyArgumentMethod.titleColorDeactiveButton] as? String ?? ""
//        ekycVC.backgroundColorCaptureDocumentScreen = args[KeyArgumentMethod.backgroundColorCaptureDocumentScreen] as? String ?? ""
//        ekycVC.backgroundColorCaptureFaceScreen = args[KeyArgumentMethod.backgroundColorCaptureFaceScreen] as? String ?? ""
//        ekycVC.effectColorNoticeFace = args[KeyArgumentMethod.effectColorNoticeFace] as? String ?? ""
//        ekycVC.textColorNoticeFace = args[KeyArgumentMethod.textColorNoticeFace] as? String ?? ""
//        ekycVC.effectColorNoticeInvalidFace = args[KeyArgumentMethod.effectColorNoticeInvalidFace] as? String ?? ""
//        ekycVC.colorContentFaceEffect = args[KeyArgumentMethod.colorContentFaceEffect] as? String ?? ""
//        ekycVC.effectColorNoticeValidDocument = args[KeyArgumentMethod.effectColorNoticeValidDocument] as? String ?? ""
//        ekycVC.effectColorNoticeInvalidDocument = args[KeyArgumentMethod.effectColorNoticeInvalidDocument] as? String ?? ""
//        ekycVC.textColorNoticeValidDocument = args[KeyArgumentMethod.textColorNoticeValidDocument] as? String ?? ""
//        ekycVC.textColorNoticeInvalidDocument = args[KeyArgumentMethod.textColorNoticeInvalidDocument] as? String ?? ""
//        ekycVC.tintColorButtonCapture = args[KeyArgumentMethod.tintColorButtonCapture] as? String ?? ""
//        ekycVC.backgroundColorBorderCaptureFace = args[KeyArgumentMethod.backgroundColorBorderCaptureFace] as? String ?? ""
        ekycVC.isShowLogo = args[KeyArgumentMethod.isShowLogo] as? Bool ?? false
//        ekycVC.logo = args[KeyArgumentMethod.logo] as? String ?? ""
//        ekycVC.logoFaceOval = args[KeyArgumentMethod.logoFaceOval] as? String ?? ""
        ekycVC.widthLogo = args[KeyArgumentMethod.widthLogo] as? Double ?? 0.0
        ekycVC.heightLogo = args[KeyArgumentMethod.heightLogo] as? Double ?? 0.0
//        ekycVC.imageTutorialQRCode = args[KeyArgumentMethod.imageTutorialQRCode] as? String ?? ""
//        ekycVC.imageTutorialFront = args[KeyArgumentMethod.imageTutorialFront] as? String ?? ""
//        ekycVC.imageTutorialBack = args[KeyArgumentMethod.imageTutorialBack] as? String ?? ""
//        ekycVC.imageTutorialBlur = args[KeyArgumentMethod.imageTutorialBlur] as? String ?? ""
//        ekycVC.imageTutorialLostAngle = args[KeyArgumentMethod.imageTutorialLostAngle] as? String ?? ""
//        ekycVC.imageTutorialGlare = args[KeyArgumentMethod.imageTutorialGlare] as? String ?? ""
//        ekycVC.backgroundColorPopup = args[KeyArgumentMethod.backgroundColorPopup] as? String ?? ""
//        ekycVC.textColorContentPopup = args[KeyArgumentMethod.textColorContentPopup] as? String ?? ""
        ekycVC.isEnableCheckVirtualCamera = args[KeyArgumentMethod.isEnableCheckVirtualCamera] as? Bool ?? false
        ekycVC.isEnableCheckSimulator = args[KeyArgumentMethod.isEnableCheckSimulator] as? Bool ?? false
        ekycVC.isEnableCheckJailbroken = args[KeyArgumentMethod.isEnableCheckJailbroken] as? Bool ?? false
        ekycVC.isAnimatedDismissed = args[KeyArgumentMethod.isAnimatedDismissed] as? Bool ?? false
    }
    
    /// Convert ScreenType enum to string representation
    /// - Parameter type: ScreenType enum value (Objective-C enum with NSUInteger rawValue)
    /// - Returns: String representation of the screen type
    private func convertScreenTypeToString(_ type: ScreenType) -> String {
        // ScreenType is an Objective-C enum with NSUInteger rawValue
        // Values: CancelPermission=0, HelpDocument=1, ScanQRCode=2, etc.
        switch type.rawValue {
        case 0: // CancelPermission
            return "CancelPermission"
        case 1: // HelpDocument
            return "HelpDocument"
        case 2: // ScanQRCode
            return "ScanQRCode"
        case 3: // CaptureFront
            return "CaptureFront"
        case 4: // CaptureBack
            return "CaptureBack"
        case 5: // HelpOval
            return "HelpOval"
        case 6: // AuthenFarFace
            return "AuthenFarFace"
        case 7: // AuthenNearFace
            return "AuthenNearFace"
        case 8: // HelpFaceBasic
            return "HelpFaceBasic"
        case 9: // CaptureFaceBasic
            return "CaptureFaceBasic"
        case 10: // Processing
            return "Processing"
        case 11: // Done
            return "Done"
        default:
            return "Unknown"
        }
    }
    
    // Định nghĩa các trạng thái để đồng bộ với bên Flutter
    struct EKYCStatus {
        static let success = "SUCCESS"
        static let cancelled = "CANCELLED"
        static let failed = "FAILED"
    }
    
    private func sendJsonResult(_ dict: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            // Trả về String JSON thành công
            pendingResult?(jsonString)
            pendingResult = nil
            
        } catch {
            print("JSON Serialization Error: \(error.localizedDescription)")
            // Trường hợp lỗi parse JSON thì vẫn trả về JSON với status FAILED
            let errorResponse: [String: Any] = [
                "status": EKYCStatus.failed,
                "data": [
                    "code": "JSON_ERROR",
                    "message": error.localizedDescription
                ]
            ]
            
            // Fallback: nếu không thể serialize error response, mới trả về FlutterError
            if let errorJsonData = try? JSONSerialization.data(withJSONObject: errorResponse, options: .prettyPrinted),
               let errorJsonString = String(data: errorJsonData, encoding: .utf8) {
                pendingResult?(errorJsonString)
            } else {
                pendingResult?(FlutterError(code: "JSON_ERROR", message: error.localizedDescription, details: nil))
            }
            pendingResult = nil
        }
    }
    
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

//MARK: eKYC delegate
extension FlutterPluginIcEkycPlugin: ICEkycCameraDelegate {


    
    // // MARK: - Success Delegate
    // public func icEkycGetResult() {
    //     UIDevice.current.isProximityMonitoringEnabled = false
        
    //     // 1. Lấy dữ liệu từ SDK
    //     let sharedData = ICEKYCSavedData.shared()
        
    //     // Kiểm tra an toàn (Optional Unwrapping) nếu cần, ở đây giả định SDK luôn trả về
    //     let cropParam = sharedData.cropParam
    //     let pathImageFrontFull = sharedData.pathImageFrontFull
    //     let pathImageBackFull = sharedData.pathImageBackFull
    //     let pathImageFaceFull = sharedData.pathImageFaceFull
    //     let pathImageFaceFarFull = sharedData.pathImageFaceFarFull
    //     let pathImageFaceNearFull = sharedData.pathImageFaceNearFull
    //     let dataScan3D = sharedData.dataScan3D
    //     let clientSessionResult = sharedData.clientSessionResult
        
    //     // Save file 3D Scan
    //     let pathFaceScan3D = saveDataToDocuments(data: dataScan3D, fileName: "3dScanPortrait", fileExtension: "txt")
        
    //     // 2. Tạo Dictionary chứa DATA thực tế
    //     let dataDict: [String: Any] = [
    //         KeyResultConstantsEKYC.cropParam: cropParam,
    //         KeyResultConstantsEKYC.pathImageFrontFull: pathImageFrontFull.path,
    //         KeyResultConstantsEKYC.pathImageBackFull: pathImageBackFull.path ,
    //         KeyResultConstantsEKYC.pathImageFaceFull: pathImageFaceFull.path ,
    //         KeyResultConstantsEKYC.pathImageFaceFarFull: pathImageFaceFarFull.path ,
    //         KeyResultConstantsEKYC.pathImageFaceNearFull: pathImageFaceNearFull.path ,
    //         KeyResultConstantsEKYC.pathImageFaceScan3D: dataScan3D.isEmpty ? "" : (pathFaceScan3D?.path ?? ""),
    //         KeyResultConstantsEKYC.clientSessionResult: clientSessionResult
    //     ]
        
    //     // 3. Đóng gói theo cấu trúc chuẩn: Status + Data
    //     let finalResponse: [String: Any] = [
    //         "status": EKYCStatus.success,
    //         "data": dataDict
    //     ]
        
    //     // 4. Serialize sang JSON String và trả về Flutter
    //     sendJsonResult(finalResponse)
    // }
    
    // public func icEkycCameraClosed(with type: ScreenType) {
    //     UIDevice.current.isProximityMonitoringEnabled = false
        
    //     let finalResponse: [String: Any] = [
    //         "status": EKYCStatus.cancelled,
    //         "data": ["lastScreen": convertScreenTypeToString(type)]
    //     ]
        
    //     sendJsonResult(finalResponse)
    // }
    
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
            KeyResultConstantsEKYC.pathImageFaceScan3D: dataScan3D.isEmpty ? "" : pathFaceScan3D?.path ?? "",
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


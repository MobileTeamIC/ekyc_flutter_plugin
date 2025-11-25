package com.vnpt.flutter_plugin_ic_ekyc

import android.app.Activity
import android.content.Intent
import android.text.TextUtils
import com.vnptit.idg.sdk.activity.VnptFrontActivity
import com.vnptit.idg.sdk.activity.VnptIdentityActivity
import com.vnptit.idg.sdk.activity.VnptOcrActivity
import com.vnptit.idg.sdk.activity.VnptPortraitActivity
import com.vnptit.idg.sdk.activity.VnptQRCodeActivity
import com.vnptit.idg.sdk.activity.VnptRearActivity
import com.vnptit.idg.sdk.utils.KeyIntentConstants
import com.vnptit.idg.sdk.utils.KeyResultConstants
import com.vnptit.idg.sdk.utils.SDKEnum
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

/** FlutterPluginIcEkycPlugin */
class FlutterPluginIcEkycPlugin : FlutterPlugin, ActivityAware ,MethodCallHandler {
    companion object {
        private const val CHANNEL = "flutter.sdk.ic_ekyc/integrate"
        private const val EKYC_REQUEST_CODE = 11022
    }

    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var result: Result? = null
    private var binding: ActivityPluginBinding? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        val binding = this.binding
        if (binding == null) {
            result.error("NO_ACTIVITY", "Activity is not available", null)
            return
        }
        
        if (this.result != null) {
            result.error("ALREADY_ACTIVE", "A request is already being processed", null)
            return
        }
        
        val activity = binding.activity
        this.result = result

        val json = parseJsonFromArgs(call)
        val intent = when (call.method) {
            "startEkycFull" -> activity.getIntentEkycFull(json)
            "startEkycOcr" -> activity.getIntentEkycOcr(json)
            "startEkycFace" -> activity.getIntentEkycFace(json)
            "startEkycOcrFront" -> activity.getIntentEkycOcrFront(json)
            "startEkycOcrBack" -> activity.getIntentEkycOcrBack(json)
            "startEkycScanQRCode" -> activity.getIntentEkycScanQRCode(json)
            else -> {
                this.result = null
                result.notImplemented()
                null
            }
        }
        intent?.let { activity.startActivityForResult(it, EKYC_REQUEST_CODE) }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
    // config for new Ekyc response
    /*
//    private val resultActivityListener = PluginRegistry.ActivityResultListener { requestCode, resultCode, data ->
//        if (requestCode == EKYC_REQUEST_CODE) {
//            val pendingResult = this.result
//            this.result = null // Clear reference ngay lập tức để tránh leak
//
//            if (pendingResult != null) {
//                val lastStep = data?.getStringExtra(KeyResultConstants.LAST_STEP)
//                val finalResponse = JSONObject()
//
//                if (resultCode == Activity.RESULT_OK && data != null && lastStep == SDKEnum.LastStepEnum.Done.value) {
//                    val dataJson = JSONObject().apply {
//                        putResult(KeyResultConstants.CROP_PARAM, data.getStringExtra(KeyResultConstants.CROP_PARAM))
//                        putResult(KeyResultConstants.PATH_IMAGE_FRONT_FULL, data.getStringExtra(KeyResultConstants.PATH_IMAGE_FRONT_FULL))
//                        putResult(KeyResultConstants.PATH_IMAGE_BACK_FULL, data.getStringExtra(KeyResultConstants.PATH_IMAGE_BACK_FULL))
//                        putResult(KeyResultConstants.PATH_IMAGE_FACE_FULL, data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_FULL))
//                        putResult(KeyResultConstants.PATH_IMAGE_FACE_FAR_FULL, data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_FAR_FULL))
//                        putResult(KeyResultConstants.PATH_IMAGE_FACE_NEAR_FULL, data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_NEAR_FULL))
//                        putResult(KeyResultConstants.PATH_FACE_SCAN3D, data.getStringExtra(KeyResultConstants.PATH_FACE_SCAN3D))
//                        putResult(KeyResultConstants.CLIENT_SESSION_RESULT, data.getStringExtra(KeyResultConstants.CLIENT_SESSION_RESULT))
//                    }
//
//                    try {
//                        finalResponse.put("status", EKYCStatus.SUCCESS)
//                        finalResponse.put("data", dataJson)
//                    } catch (e: JSONException) {
//                        e.printStackTrace()
//                    }
//                } else {
//                    try {
//                        var canceledJson = JSONObject()
//                        canceledJson.put("lastScreen", lastStep)
//                        finalResponse.put("status", EKYCStatus.CANCELLED)
//                        finalResponse.put("data", canceledJson)
//                    } catch (e: JSONException) {
//                        pendingResult.error("JSON_ERROR", e.message, e.message)
//                    }
//                }
//                pendingResult.success(finalResponse.toString())
//            }
//        }
//        true
//    }
*/
    private val resultActivityListener = PluginRegistry.ActivityResultListener { requestCode, resultCode, data ->
        if (requestCode == EKYC_REQUEST_CODE) {
            val pendingResult = this.result
            this.result = null

            if (pendingResult != null) {

                val lastStep = data?.getStringExtra(KeyResultConstants.LAST_STEP)
                if (resultCode == Activity.RESULT_OK ) {
                    if (data != null && lastStep == SDKEnum.LastStepEnum.Done.value) {
                        val cropPram = data.getStringExtra(KeyResultConstants.CROP_PARAM)
                        val pathImageFrontFull =
                            data.getStringExtra(KeyResultConstants.PATH_IMAGE_FRONT_FULL)
                        val pathImageBackFull =
                            data.getStringExtra(KeyResultConstants.PATH_IMAGE_BACK_FULL)
                        val pathImageFaceFull =
                            data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_FULL)
                        val pathImageFaceFarFull =
                            data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_FAR_FULL)
                        val pathImageFaceNearFull =
                            data.getStringExtra(KeyResultConstants.PATH_IMAGE_FACE_NEAR_FULL)
                        val pathImageScan3DFull =
                            data.getStringExtra(KeyResultConstants.PATH_FACE_SCAN3D)
                        val clientSessionResult =
                            data.getStringExtra(KeyResultConstants.CLIENT_SESSION_RESULT)
                        pendingResult.success(
                            JSONObject().apply {
                                putSafe(KeyResultConstants.CROP_PARAM, cropPram)
                                putSafe(
                                    KeyResultConstants.PATH_IMAGE_FRONT_FULL,
                                    pathImageFrontFull
                                )
                                putSafe(KeyResultConstants.PATH_IMAGE_BACK_FULL, pathImageBackFull)
                                putSafe(KeyResultConstants.PATH_IMAGE_FACE_FULL, pathImageFaceFull)
                                putSafe(
                                    KeyResultConstants.PATH_IMAGE_FACE_FAR_FULL,
                                    pathImageFaceFarFull
                                )
                                putSafe(
                                    KeyResultConstants.PATH_IMAGE_FACE_NEAR_FULL,
                                    pathImageFaceNearFull
                                )
                                putSafe(
                                    KeyResultConstants.PATH_FACE_SCAN3D,
                                    pathImageScan3DFull
                                )
                                putSafe(
                                    KeyResultConstants.CLIENT_SESSION_RESULT,
                                    clientSessionResult
                                )
                            }.toString()
                        )
                    } else {
                        pendingResult.error("CANCELLED", "User canceled the operation", null)
                    }
                } else {
                    pendingResult.error("CANCELLED", "User canceled the operation", null)
                }
            }
        }
        true
    }
    // Phương thức thực hiện eKYC luồng "Chụp ảnh giấy tờ"
    // Bước 1 - chụp ảnh giấy tờ
    // Bước 2 - hiển thị kết quả
    private fun Activity.getIntentEkycOcr(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptOcrActivity::class.java, json)

        // document_type
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            mapDocumentType(json.optString("document_type"))
        )

        // is_check_liveness_card
        intent.putExtra(KeyIntentConstants.IS_CHECK_LIVENESS_CARD, json.optBoolean("is_check_liveness_card", true))

        // validate_document_type
        intent.putExtra(
            KeyIntentConstants.VALIDATE_DOCUMENT_TYPE,
            mapValidateDocument(json.optString("validate_document_type"))
        )

        return intent
    }

    // Phương thức thực hiện eKYC luồng đầy đủ bao gồm: Chụp ảnh giấy tờ và chụp ảnh chân dung
    // Bước 1 - chụp ảnh giấy tờ
    // Bước 2 - chụp ảnh chân dung xa gần
    // Bước 3 - hiển thị kết quả

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
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    private fun Activity.getIntentEkycFull(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptIdentityActivity::class.java, json)

        // document_type
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            mapDocumentType(json.optString(KeyArgumentMethod.DOCUMENT_TYPE))
        )

        // is_enable_compare
        intent.putExtra(KeyIntentConstants.IS_ENABLE_COMPARE,
            json.optBoolean(KeyArgumentMethod.IS_ENABLE_COMPARE, false)
        )

        // is_check_liveness_card
        intent.putExtra(KeyIntentConstants.IS_CHECK_LIVENESS_CARD,
            json.optBoolean(KeyArgumentMethod.IS_CHECK_LIVENESS_CARD, false)
        )

        // check_liveness_face
        intent.putExtra(
            KeyIntentConstants.CHECK_LIVENESS_FACE,
            mapLivenessFace(json.optString(KeyArgumentMethod.CHECK_LIVENESS_FACE))
        )

        // is_check_masked_face
        intent.putExtra(KeyIntentConstants.IS_CHECK_MASKED_FACE,
            json.optBoolean(KeyArgumentMethod.IS_CHECK_MASKED_FACE, false)
        )

        // validate_document_type
        intent.putExtra(
            KeyIntentConstants.VALIDATE_DOCUMENT_TYPE,
            mapValidateDocument(json.optString(KeyArgumentMethod.VALIDATE_DOCUMENT_TYPE))
        )

        // is_validate_postcode
        intent.putExtra(KeyIntentConstants.IS_VALIDATE_POSTCODE,
            json.optBoolean(KeyArgumentMethod.IS_VALIDATE_POSTCODE, false)
        )

        // version_sdk
        intent.putExtra(
            KeyIntentConstants.VERSION_SDK,
            mapVersionSdk(json.optString(KeyArgumentMethod.VERSION_SDK))
        )

       

        return intent
    }

    // MARK: - FACE
    /// Luồng chỉ thực hiện xác thực khuôn mặt: Face Verification
    ///
    /// Thực hiện chụp ảnh Oval xa gần và thực hiện các chức năng tùy vào cấu hình: Compare, Verify, Mask, Liveness Face
    ///
    /// - Required Parameters (info):
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
    /// - Optional Parameters (info):
    ///   - version_sdk: Phiên bản SDK cho chụp ảnh chân dung ("normal", "prooval")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_enable_compare: Bật/tắt chức năng so sánh ảnh chân dung ("true"/"false")
    ///   - is_check_masked_face: Bật/tắt chức năng kiểm tra che mặt ("true"/"false")
    ///   - check_liveness_face: Chức năng kiểm tra ảnh chân dung chụp trực tiếp ("nonecheckface", "ibeta", "standard")
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    private fun Activity.getIntentEkycFace(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptPortraitActivity::class.java, json)

        // version_sdk: normal|prooval (map -> Standard|ADVANCED)
        intent.putExtra(
            KeyIntentConstants.VERSION_SDK,
            mapVersionSdk(json.optString(KeyArgumentMethod.VERSION_SDK))
        )

        // is_enable_compare
        intent.putExtra(KeyIntentConstants.IS_ENABLE_COMPARE, json.optBoolean(KeyArgumentMethod.IS_ENABLE_COMPARE, false))

        // hash image compare
        intent.putExtra(KeyIntentConstants.HASH_IMAGE_COMPARE, json.optString(KeyArgumentMethod.HASH_IMAGE_COMPARE, ""))

        // is_check_masked_face
        intent.putExtra(KeyIntentConstants.IS_CHECK_MASKED_FACE, json.optBoolean(KeyArgumentMethod.IS_CHECK_MASKED_FACE, false))

        // check_liveness_face: nonecheckface|ibeta|standard
        intent.putExtra(
            KeyIntentConstants.CHECK_LIVENESS_FACE,
            mapLivenessFace(json.optString(KeyArgumentMethod.CHECK_LIVENESS_FACE))
        )

        return intent
    }

    // MARK: - OCR FRONT
    /// Luồng chỉ thực hiện đọc giấy tờ chỉ mặt trước: OCR Front
    ///
    /// Thực hiện OCR giấy tờ một bước: chụp mặt trước giấy tờ
    ///
    /// - Required Parameters (info):
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
    /// - Optional Parameters (info):
    ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
    ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    private fun Activity.getIntentEkycOcrFront(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptFrontActivity::class.java, json)

        // document_type
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            mapDocumentType(json.optString(KeyArgumentMethod.DOCUMENT_TYPE))
        )

        // is_check_liveness_card
        intent.putExtra(KeyIntentConstants.IS_CHECK_LIVENESS_CARD, json.optBoolean(KeyArgumentMethod.IS_CHECK_LIVENESS_CARD, true))

        // validate_document_type
        intent.putExtra(
            KeyIntentConstants.VALIDATE_DOCUMENT_TYPE,
            mapValidateDocument(json.optString(KeyArgumentMethod.VALIDATE_DOCUMENT_TYPE))
        )


        return intent
    }

    // MARK: - OCR BACK
    /// Luồng chỉ thực hiện đọc giấy tờ chỉ mặt sau: OCR Back
    ///
    /// Thực hiện OCR giấy tờ một bước: chụp mặt sau giấy tờ
    ///
    /// - Required Parameters (info):
    ///   - access_token: Mã truy cập từ eKYC admin dashboard
    ///   - token_id: Token ID từ eKYC admin dashboard
    ///   - token_key: Token key từ eKYC admin dashboard
    ///
    /// - Optional Parameters (info):
    ///   - document_type: Loại giấy tờ ("identitycard", "idcardchipbased", "passport", "driverlicense", "militaryidcard")
    ///   - is_show_tutorial: Hiển thị màn hình hướng dẫn ("true"/"false")
    ///   - hash_front_ocr: Hash của kết quả OCR mặt trước (bắt buộc cho ocrback)
    ///   - is_check_liveness_card: Bật/tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp ("true"/"false")
    ///   - validate_document_type: Chế độ kiểm tra ảnh giấy tờ ("none", "basic", "medium", "advance")
    ///   - is_enable_gotit: Bật/tắt nút "Bỏ qua hướng dẫn" ("true"/"false")
    ///   - language_sdk: Ngôn ngữ SDK ("icekyc_vi", "icekyc_en")
    ///   - is_show_logo: Bật/tắt hiển thị LOGO thương hiệu ("true"/"false")
    private fun Activity.getIntentEkycOcrBack(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptRearActivity::class.java, json)

        // document_type
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            mapDocumentType(json.optString(KeyArgumentMethod.DOCUMENT_TYPE))
        )

        // hash_front_ocr (bắt buộc cho ocrback)
        if (json.has(KeyArgumentMethod.HASH_FRONT_OCR)) {
            intent.putExtra(KeyIntentConstants.HASH_FRONT_OCR, json.optString(KeyArgumentMethod.HASH_FRONT_OCR))
        }

        // is_check_liveness_card
        intent.putExtra(KeyIntentConstants.IS_CHECK_LIVENESS_CARD, json.optBoolean(KeyArgumentMethod.IS_CHECK_LIVENESS_CARD, true))

        // validate_document_type
        intent.putExtra(
            KeyIntentConstants.VALIDATE_DOCUMENT_TYPE,
            mapValidateDocument(json.optString(KeyArgumentMethod.VALIDATE_DOCUMENT_TYPE))
        )

        return intent
    }

    // MARK: - SCAN QR CODE
    /// Luồng chỉ thực hiện quét QR code: Scan QR Code
    ///
    /// Thực hiện quét QR code để lấy thông tin từ QR code
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
    private fun Activity.getIntentEkycScanQRCode(json: JSONObject): Intent {
        val intent = getBaseIntent(VnptQRCodeActivity::class.java, json)
        return intent
    }

    ///MARK: BASE INTENT
    private fun <T : Activity> Activity.getBaseIntent(clazz: Class<T>, json: JSONObject): Intent {
        val intent = Intent(this, clazz)

        // ACCESS_TOKEN
        intent.putExtra(
            KeyIntentConstants.ACCESS_TOKEN,
            if (json.has(KeyArgumentMethod.ACCESS_TOKEN)) json.getString(KeyArgumentMethod.ACCESS_TOKEN) else ""
        )
        intent.putExtra(
            KeyIntentConstants.TOKEN_ID,
            if (json.has(KeyArgumentMethod.TOKEN_ID)) json.getString(KeyArgumentMethod.TOKEN_ID) else ""
        )
        intent.putExtra(
            KeyIntentConstants.TOKEN_KEY,
            if (json.has(KeyArgumentMethod.TOKEN_KEY)) json.getString(KeyArgumentMethod.TOKEN_KEY) else ""
        )

        // Challenge code
        intent.putExtra(
            KeyIntentConstants.CHALLENGE_CODE,
            if (json.has(KeyArgumentMethod.CHALLENGE_CODE)) json.getString(KeyArgumentMethod.CHALLENGE_CODE) else "")

        // Ngôn ngữ sử dụng trong SDK
        // - VIETNAMESE: Tiếng Việt
        // - ENGLISH: Tiếng Anh
        intent.putExtra(
            KeyIntentConstants.LANGUAGE_SDK,
            mapLanguage(json.optString(KeyArgumentMethod.LANGUAGE_SDK)).value
        )

        // is_show_tutorial
        intent.putExtra(KeyIntentConstants.IS_SHOW_TUTORIAL, json.optBoolean(KeyArgumentMethod.IS_SHOW_TUTORIAL, false))

        // is_disable_tutorial
        intent.putExtra(KeyIntentConstants.IS_DISABLE_TUTORIAL, json.optBoolean(KeyArgumentMethod.IS_DISABLE_TUTORIAL, false))

        // is_enable_gotit
        intent.putExtra(KeyIntentConstants.IS_ENABLE_GOT_IT, json.optBoolean(KeyArgumentMethod.IS_ENABLE_GOT_IT, false))

        // is_show_logo
        intent.putExtra(KeyIntentConstants.IS_SHOW_LOGO, json.optBoolean(KeyArgumentMethod.IS_SHOW_LOGO, false))

        // is_enable_scan_qrcode
        intent.putExtra(
            KeyIntentConstants.IS_ENABLE_SCAN_QRCODE,
            json.optBoolean(KeyArgumentMethod.IS_ENABLE_SCAN_QR_CODE, false)
        )

        intent.putExtra(
            KeyIntentConstants.IS_TURN_OFF_CALL_SERVICE,
            json.optBoolean(KeyArgumentMethod.IS_TURN_OFF_CALL_SERVICE, false)
        )

        // change_base_url
        intent.putExtra(KeyIntentConstants.CHANGE_BASE_URL, json.optString(KeyArgumentMethod.CHANGE_BASE_URL))
        
        // input_client_session
        intent.putExtra(KeyIntentConstants.INPUT_CLIENT_SESSION, json.optString(KeyArgumentMethod.INPUT_CLIENT_SESSION, ""))

        // is_show_required_permission_decree
        intent.putExtra(KeyIntentConstants.IS_SHOW_REQUIRED_PERMISSION_DECREE, json.optBoolean(KeyArgumentMethod.IS_SHOW_REQUIRED_PERMISSION_DECREE, false))

        // is_enable_tutorial_card_advance
        intent.putExtra(KeyIntentConstants.IS_ENABLE_TUTORIAL_CARD_ADVANCE, json.optBoolean(KeyArgumentMethod.IS_ENABLE_TUTORIAL_CARD_ADVANCE, false))

        // is_show_switch_camera
        intent.putExtra(KeyIntentConstants.IS_SHOW_SWITCH_CAMERA, json.optBoolean(KeyArgumentMethod.IS_SHOW_SWITCH_CAMERA, false))

        // camera_position_for_portrait
        intent.putExtra(KeyIntentConstants.CAMERA_POSITION_FOR_PORTRAIT, mapCameraPositionForPortrait(json.optString(KeyArgumentMethod.CAMERA_POSITION_FOR_PORTRAIT)))

        // zoom_camera
        intent.putExtra(KeyIntentConstants.ZOOM_CAMERA, json.optDouble(KeyArgumentMethod.ZOOM_CAMERA, 0.0))

        // is_enable_auto_brightness
        intent.putExtra(KeyIntentConstants.IS_ENABLE_AUTO_BRIGHTNESS, json.optBoolean(KeyArgumentMethod.IS_ENABLE_AUTO_BRIGHTNESS, false))

        // screen_brightness
        intent.putExtra(KeyIntentConstants.SCREEN_BRIGHTNESS, json.optDouble(KeyArgumentMethod.SCREEN_BRIGHTNESS, 0.0))
        
        // is_skip_preview
        intent.putExtra(KeyIntentConstants.IS_SKIP_PREVIEW, json.optBoolean(KeyArgumentMethod.IS_SKIP_PREVIEW, false))

        // is_enable_encrypt
        intent.putExtra(KeyIntentConstants.IS_ENABLE_ENCRYPT, json.optBoolean(KeyArgumentMethod.IS_ENABLE_ENCRYPT, false))

        // mode_button_header_bar: leftButton|rightButton
        intent.putExtra(KeyIntentConstants.MODE_BUTTON_HEADER_BAR, mapModeButtonHeaderBar(json.optString(KeyArgumentMethod.MODE_BUTTON_HEADER_BAR)))
        
        // time_out_call_api
        intent.putExtra(KeyIntentConstants.TIMEOUT_CALL_API, json.optInt(KeyArgumentMethod.TIMEOUT_CALL_API, 20))

        return intent
    }

    // Mark: - Helper

    object EKYCStatus {
        const val SUCCESS = "SUCCESS"
        const val CANCELLED = "CANCELLED"
        const val FAILED = "FAILED"
    }
    private fun parseJsonFromArgs(call: MethodCall): JSONObject {
        return try {
            @Suppress("UNCHECKED_CAST")
            (JSONObject(call.arguments as Map<String, Any>))
        } catch (e: Exception) {
            JSONObject(mapOf<String, Any>())
        }
    }

    // Hàm helper để chuyển JSONArray thành List
    fun toList(jsonArray: JSONArray): List<Any> {
        val list = ArrayList<Any>()
        for (i in 0 until jsonArray.length()) {
            val value = jsonArray.get(i)
            when (value) {
                is JSONObject -> list.add(toMap(value))
                is JSONArray -> list.add(toList(value))
                else -> list.add(value)
            }
        }
        return list
    }

    fun toMap(jsonObject: JSONObject): Map<String, Any> {
        val map = HashMap<String, Any>()
        val keys = jsonObject.keys()
        while (keys.hasNext()) {
            val key = keys.next()
            val value = jsonObject.get(key)
            when (value) {
                is JSONObject -> map[key] = toMap(value)
                is JSONArray -> map[key] = toList(value)
                else -> map[key] = value
            }
        }
        return map
    }

    // Hàm helper để parse JSON string thành Map hoặc trả về null nếu không phải JSON hợp lệ
    private fun parseJsonStringToMap(jsonString: String?): Any? {
        if (jsonString.isNullOrBlank()) return null
        return try {
            val jsonObject = JSONObject(jsonString)
            toMap(jsonObject)
        } catch (e: Exception) {
            // Nếu không phải JSONObject, thử parse như JSONArray
            try {
                val jsonArray = JSONArray(jsonString)
                toList(jsonArray)
            } catch (e2: Exception) {
                // Nếu không phải JSON hợp lệ, trả về string gốc
                jsonString
            }
        }
    }

    // Hàm helper để put postcode value vào JSONObject (parse JSON string thành Map nếu cần)
    private fun JSONObject.putResult(key: String, jsonString: String?) {
        if (jsonString.isNullOrBlank()) return

        val parsedValue = parseJsonStringToMap(jsonString)
        when (parsedValue) {
            is Map<*, *> -> {
                // Nếu là Map, chuyển thành JSONObject
                try {
                    put(key, JSONObject(parsedValue as Map<String, Any>))
                } catch (e: Exception) {
                    // Nếu chuyển đổi thất bại, giữ nguyên string
                    putSafe(key, jsonString)
                }
            }
            is List<*> -> {
                // Nếu là List, chuyển thành JSONArray
                try {
                    put(key, JSONArray(parsedValue as List<Any>))
                } catch (e: Exception) {
                    // Nếu chuyển đổi thất bại, giữ nguyên string
                    putSafe(key, jsonString)
                }
            }
            else -> {
                // Nếu không phải Map hoặc List, giữ nguyên string
                putSafe(key, jsonString)
            }
        }
    }

    /**
     * put value to [JSONObject] with null-safety
     */
    private fun JSONObject.putSafe(key: String, value: String?, prettify: Boolean = true) {
        value?.let {
            if (prettify) {
                val prettified = JsonUtil.prettify(it)
                if (prettified != null) {
                    put(key, prettified)
                } else {
                    put(key, it)
                }
            } else {
                put(key, it)
            }
        }
    }

    // region Mappers from Dart/iOS-friendly strings to Android SDK enums
    private fun mapVersionSdk(value: String?): Int {
        return when (value?.lowercase()) {
            "normal" -> SDKEnum.VersionSDKEnum.STANDARD.value
            "prooval" -> SDKEnum.VersionSDKEnum.ADVANCED.value
            else -> SDKEnum.VersionSDKEnum.STANDARD.value
        }
    }

    private fun mapDocumentType(value: String?): Int {
        return when (value?.lowercase()) {
            "identitycard" -> SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
            "idcardchipbased" -> SDKEnum.DocumentTypeEnum.IDENTITY_CARD_CHIP.value
            "passport" -> SDKEnum.DocumentTypeEnum.PASSPORT.value
            "driverlicense" -> SDKEnum.DocumentTypeEnum.DRIVER_LICENSE.value
            "militaryidcard" -> SDKEnum.DocumentTypeEnum.MILITARY_CARD.value
            else -> SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
        }
    }

    private fun mapValidateDocument(value: String?): Int {
        return when (value?.lowercase()) {
            "none" -> SDKEnum.ValidateDocumentType.None.value
            "basic" -> SDKEnum.ValidateDocumentType.Basic.value
            "medium" -> SDKEnum.ValidateDocumentType.Medium.value
            "advance" -> SDKEnum.ValidateDocumentType.Advance.value
            else -> SDKEnum.ValidateDocumentType.None.value
        }
    }

    private fun mapModeButtonHeaderBar(value: String?): Int {
        return when (value?.lowercase()) {
            "rightbutton" -> SDKEnum.ModeButtonHeaderBar.RightButton.value
            "leftbutton" -> SDKEnum.ModeButtonHeaderBar.LeftButton.value
            else -> SDKEnum.ModeButtonHeaderBar.LeftButton.value
        }
    }

    private fun mapCameraPositionForPortrait(value: String?): Int {
        return when (value?.lowercase()) {
            "positionfront" -> SDKEnum.CameraTypeEnum.FRONT.value
            "positionback" -> SDKEnum.CameraTypeEnum.BACK.value
            else -> SDKEnum.CameraTypeEnum.FRONT.value
        }
    }

    private fun mapLivenessFace(value: String?): Int {
        return when (value?.lowercase()) {
            "nonecheckface" -> SDKEnum.ModeCheckLiveNessFace.NONE.value
            "ibeta" -> SDKEnum.ModeCheckLiveNessFace.iBETA.value
            "standard" -> SDKEnum.ModeCheckLiveNessFace.STANDARD.value
            else -> SDKEnum.ModeCheckLiveNessFace.NONE.value
        }
    }

    private fun mapLanguage(value: String?): SDKEnum.LanguageEnum {
        return when (value?.lowercase()) {
            "icekyc_en" -> SDKEnum.LanguageEnum.ENGLISH
            else -> SDKEnum.LanguageEnum.VIETNAMESE
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener(resultActivityListener)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
        binding?.removeActivityResultListener(resultActivityListener)
        binding = null
    }
    // endregion
}

import 'package:shared_preferences/shared_preferences.dart';

/// Service class để quản lý SharedPreferences
/// Cung cấp các phương thức để lưu và đọc dữ liệu local
class SharedPreferenceService {
  SharedPreferenceService();

  static final SharedPreferenceService _instance = SharedPreferenceService();

  static late final SharedPreferences _sharedPreferences;

  static SharedPreferenceService get instance => _instance;

  static void init(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// Lưu String
  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  /// Đọc String
  String getString(String key) {
    return _sharedPreferences.getString(key) ?? '';
  }

  /// Lưu int
  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  /// Đọc int
  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  /// Lưu double
  Future<bool> setDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  /// Đọc double
  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  /// Lưu bool
  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  /// Đọc bool
  bool getBool(String key, {bool defaultValue = false}) {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  /// Lưu List<String>
  Future<bool> setStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  /// Đọc List<String>
  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  /// Xóa một key
  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  /// Xóa tất cả dữ liệu
  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  /// Kiểm tra key có tồn tại không
  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  /// Lấy tất cả các keys
  Set<String> getAllKeys() {
    return _sharedPreferences.getKeys();
  }

  /// Reload SharedPreferences
  Future<void> reload() async {
    await _sharedPreferences.reload();
  }
}

class SharedPreferenceKeys {
  static const String accessToken = 'access_token';
  static const String tokenId = 'token_id';
  static const String tokenKey = 'token_key';
  static const String baseUrl = 'base_url';
  static const String isViLanguageMode = 'is_vi_language_mode';
  static const String modeButtonHeaderBar = 'mode_button_header_bar';
  static const String isShowLogo = 'is_show_logo';
  static const String isShowTutorial = 'is_show_tutorial';
  static const String isEnableGotIt = 'is_enable_got_it';
  
  // QR Code configuration
  static const String numberTimesRetryScanQRCode = 'number_times_retry_scan_qrcode';
  static const String timeoutQRCodeFlow = 'timeout_qrcode_flow';

  // UI Configuration
  static const String imageTutorialQRCode = 'image_tutorial_qrcode';
  static const String imageTutorialFront = 'image_tutorial_front';
  static const String imageTutorialBack = 'image_tutorial_back';
  static const String imageTutorialBlur = 'image_tutorial_blur';
  static const String imageTutorialLostAngle = 'image_tutorial_lost_angle';
  static const String imageTutorialGlare = 'image_tutorial_glare';

  static const String logo = 'logo';
  static const String logoFaceOval = 'logo_face_oval';
  
  // Color configurations
  static const String contentColorHeaderBar = 'content_color_header_bar';
  static const String backgroundColorHeaderBar = 'background_color_header_bar';
  static const String titleColorMain = 'title_color_main';
  static const String backgroundColorMainScreen = 'background_color_main_screen';
  static const String backgroundColorActiveButton = 'background_color_active_button';
  static const String titleColorActiveButton = 'title_color_active_button';
  static const String effectColorNoticeFace = 'effect_color_notice_face';
  static const String backgroundColorPopup = 'background_color_popup';
  static const String backgroundColorBorderCaptureFace = 'background_color_border_capture_face';
  
  // Additional color configurations (15 colors)
  static const String textColorContentMain = 'text_color_content_main';
  static const String backgroundColorLine = 'background_color_line';
  static const String backgroundColorDeactiveButton = 'background_color_deactive_button';
  static const String titleColorDeactiveButton = 'title_color_deactive_button';
  static const String backgroundColorCaptureDocumentScreen = 'background_color_capture_document_screen';
  static const String backgroundColorCaptureFaceScreen = 'background_color_capture_face_screen';
  static const String textColorNoticeFace = 'text_color_notice_face';
  static const String effectColorNoticeInvalidFace = 'effect_color_notice_invalid_face';
  static const String colorContentFaceEffect = 'color_content_face_effect';
  static const String effectColorNoticeValidDocument = 'effect_color_notice_valid_document';
  static const String effectColorNoticeInvalidDocument = 'effect_color_notice_invalid_document';
  static const String textColorNoticeValidDocument = 'text_color_notice_valid_document';
  static const String textColorNoticeInvalidDocument = 'text_color_notice_invalid_document';
  static const String tintColorButtonCapture = 'tint_color_button_capture';
  static const String textColorContentPopup = 'text_color_content_popup';
}

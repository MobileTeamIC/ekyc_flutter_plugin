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
}

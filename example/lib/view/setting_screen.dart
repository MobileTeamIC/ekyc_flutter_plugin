import 'package:flutter/material.dart';
import 'package:flutter_plugin_ic_ekyc/ekyc/services/enum_ekyc.dart';

import '../service/shared_preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accessTokenController = TextEditingController();
  final TextEditingController _tokenIdController = TextEditingController();
  final TextEditingController _tokenKeyController = TextEditingController();
  final TextEditingController _baseUrlController = TextEditingController();
  bool _isLoading = false;
  LanguageSdk _languageSdk = LanguageSdk.icekyc_vi;
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    _accessTokenController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessToken,
    );
    _tokenIdController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenId,
    );
    _tokenKeyController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKey,
    );
    _baseUrlController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.baseUrl,
    );
    _languageSdk =
        SharedPreferenceService.instance.getBool(
              SharedPreferenceKeys.isViLanguageMode,
              defaultValue: true,
            )
            ? LanguageSdk.icekyc_vi
            : LanguageSdk.icekyc_en;
  }

  @override
  void dispose() {
    _accessTokenController.dispose();
    _tokenIdController.dispose();
    _tokenKeyController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.wait([
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.accessToken,
          _accessTokenController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenId,
          _tokenIdController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenKey,
          _tokenKeyController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.baseUrl,
          _baseUrlController.text.trim(),
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isViLanguageMode,
          _languageSdk == LanguageSdk.icekyc_vi,
        ),
      ]);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Đã lưu cài đặt thành công'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Lỗi khi lưu: $e')),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _languageSdk.name,
                  items: [
                    DropdownMenuItem(
                      value: LanguageSdk.icekyc_vi.name,
                      child: const Text('Tiếng Việt'),
                    ),
                    DropdownMenuItem(
                      value: LanguageSdk.icekyc_en.name,
                      child: const Text('Tiếng Anh'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _languageSdk = LanguageSdk.values.firstWhere((e) => e.name == value));
                  },
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _accessTokenController,
                  decoration: const InputDecoration(
                    labelText: 'Access Token',
                    hintText: 'Nhập Access Token',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _tokenIdController,
                  decoration: const InputDecoration(
                    labelText: 'Token ID',
                    hintText: 'Nhập Token ID',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _tokenKeyController,
                  decoration: const InputDecoration(
                    labelText: 'Token Key',
                    hintText: 'Nhập Token Key',
                    prefixIcon: Icon(Icons.key),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _baseUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Base URL',
                    hintText: 'https://api.example.com',
                    prefixIcon: Icon(Icons.link),
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                 ElevatedButton(
                    onPressed: _isLoading ? null : _saveSettings,
                    child: Text(_isLoading ? 'Đang lưu...' : 'Lưu cài đặt'),
                  ),
                  const SizedBox(height: 16),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

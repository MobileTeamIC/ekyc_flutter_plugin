import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../service/shared_preference.dart';
import '../theme/context.dart';

class ConfigUiScreen extends StatefulWidget {
  const ConfigUiScreen({super.key});

  @override
  State<ConfigUiScreen> createState() => _ConfigUiScreenState();
}

class _ConfigUiScreenState extends State<ConfigUiScreen> {
  bool _isLoading = false;

  final List<String> _availableAssets = [
    'assets/img_nfc/blue_markframe_bg.png',
    'assets/img_nfc/dismiss_back_ic.png',
    'assets/img_nfc/dismiss_close_ic.png',
    'assets/img_nfc/logo_vnpt_ic.png',
    'assets/img_nfc/mrz_code_too_blurry_ic.png',
    'assets/img_nfc/number_encrypt_bg.png',
    'assets/img_nfc/qr_code_missing_corner_ic.png',
    'assets/img_nfc/qr_code_over_exposure_ic.png',
    'assets/img_nfc/qr_code_too_blurry_ic.png',
    'assets/img_nfc/qrcode_failed_ic.png',
    'assets/img_nfc/qrcode_scan_markframe_bg.png',
    'assets/img_nfc/scan_mrz_ic.png',
    'assets/img_nfc/scan_qr_ic.png',
    'assets/img_nfc/skip_video_ic.png',
    'assets/img_nfc/warning_ic.png',
  ];

  String _imageTutorialQRCode = '';
  String _imageTutorialFront = '';
  String _imageTutorialBack = '';
  String _imageTutorialBlur = '';
  String _imageTutorialLostAngle = '';
  String _imageTutorialGlare = '';
  String _logo = '';
  String _logoFaceOval = '';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _imageTutorialQRCode = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialQRCode);
      _imageTutorialFront = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialFront);
      _imageTutorialBack = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialBack);
      _imageTutorialBlur = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialBlur);
      _imageTutorialLostAngle = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialLostAngle);
      _imageTutorialGlare = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialGlare);
      _logo = SharedPreferenceService.instance.getString(SharedPreferenceKeys.logo);
      _logoFaceOval = SharedPreferenceService.instance.getString(SharedPreferenceKeys.logoFaceOval);
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);

    try {
      await Future.wait([
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialQRCode, _imageTutorialQRCode),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialFront, _imageTutorialFront),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialBack, _imageTutorialBack),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialBlur, _imageTutorialBlur),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialLostAngle, _imageTutorialLostAngle),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.imageTutorialGlare, _imageTutorialGlare),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.logo, _logo),
        SharedPreferenceService.instance.setString(SharedPreferenceKeys.logoFaceOval, _logoFaceOval),
      ]);

      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: const Text('Đã lưu cấu hình UI thành công'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.primary,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Lỗi khi lưu: $e'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.destructive,
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
      appBar: AppBar(title: Text('Cấu hình UI', style: context.textTheme.h3)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSelectionField('Ảnh Hướng dẫn QR Code', _imageTutorialQRCode, (v) => setState(() => _imageTutorialQRCode = v ?? '')),
                    _buildSelectionField('Ảnh Hướng dẫn Mặt trước', _imageTutorialFront, (v) => setState(() => _imageTutorialFront = v ?? '')),
                    _buildSelectionField('Ảnh Hướng dẫn Mặt sau', _imageTutorialBack, (v) => setState(() => _imageTutorialBack = v ?? '')),
                    _buildSelectionField('Ảnh Hướng dẫn Bị mờ', _imageTutorialBlur, (v) => setState(() => _imageTutorialBlur = v ?? '')),
                    _buildSelectionField('Ảnh Hướng dẫn Mất góc', _imageTutorialLostAngle, (v) => setState(() => _imageTutorialLostAngle = v ?? '')),
                    _buildSelectionField('Ảnh Hướng dẫn Bị lóa', _imageTutorialGlare, (v) => setState(() => _imageTutorialGlare = v ?? '')),
                    _buildSelectionField('Logo Thương hiệu', _logo, (v) => setState(() => _logo = v ?? '')),
                    _buildSelectionField('Logo Khuôn mặt Oval', _logoFaceOval, (v) => setState(() => _logoFaceOval = v ?? '')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ShadButton(
                onPressed: _isLoading ? null : _saveSettings,
                backgroundColor: context.colorScheme.primary,
                width: double.infinity,
                height: 48,
                child: Text(
                  _isLoading ? 'Đang lưu...' : 'Lưu cấu hình',
                  style: context.textTheme.large,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionField(String title, String currentValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: context.textTheme.h4),
        ShadSelect<String>(
          selectedOptionBuilder: (context, value) => Text(value.split('/').last),
          placeholder: const Text('Chọn ảnh hướng dẫn'),
          options: [
            const ShadOption(value: '', child: Text('Mặc định SDK')),
            ..._availableAssets.map((asset) => ShadOption(
                  value: asset,
                  child: Row(
                    children: [
                      Image.asset(asset, width: 30, height: 30, errorBuilder: (c, e, s) => const Icon(Icons.image, size: 30)),
                      const SizedBox(width: 10),
                      Text(asset.split('/').last),
                    ],
                  ),
                )),
          ],
          initialValue: currentValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

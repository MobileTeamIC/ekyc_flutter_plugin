import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  // Color configurations
  Color? _contentColorHeaderBar;
  Color? _backgroundColorHeaderBar;
  Color? _titleColorMain;
  Color? _backgroundColorMainScreen;
  Color? _backgroundColorActiveButton;
  Color? _titleColorActiveButton;
  Color? _effectColorNoticeFace;
  Color? _backgroundColorPopup;
  Color? _backgroundColorBorderCaptureFace;
  
  Color? _textColorContentMain;
  Color? _backgroundColorLine;
  Color? _backgroundColorDeactiveButton;
  Color? _titleColorDeactiveButton;
  Color? _backgroundColorCaptureDocumentScreen;
  Color? _backgroundColorCaptureFaceScreen;
  Color? _textColorNoticeFace;
  Color? _effectColorNoticeInvalidFace;
  Color? _colorContentFaceEffect;
  Color? _effectColorNoticeValidDocument;
  Color? _effectColorNoticeInvalidDocument;
  Color? _textColorNoticeValidDocument;
  Color? _textColorNoticeInvalidDocument;
  Color? _tintColorButtonCapture;
  Color? _textColorContentPopup;
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

      // Load color configurations
      _contentColorHeaderBar = _loadColor(SharedPreferenceKeys.contentColorHeaderBar);
      _backgroundColorHeaderBar = _loadColor(SharedPreferenceKeys.backgroundColorHeaderBar);
      _titleColorMain = _loadColor(SharedPreferenceKeys.titleColorMain);
      _backgroundColorMainScreen = _loadColor(SharedPreferenceKeys.backgroundColorMainScreen);
      _backgroundColorActiveButton = _loadColor(SharedPreferenceKeys.backgroundColorActiveButton);
      _titleColorActiveButton = _loadColor(SharedPreferenceKeys.titleColorActiveButton);
      _effectColorNoticeFace = _loadColor(SharedPreferenceKeys.effectColorNoticeFace);
      _backgroundColorPopup = _loadColor(SharedPreferenceKeys.backgroundColorPopup);
      _backgroundColorBorderCaptureFace = _loadColor(SharedPreferenceKeys.backgroundColorBorderCaptureFace);
      _textColorContentMain = _loadColor(SharedPreferenceKeys.textColorContentMain);
      _backgroundColorLine = _loadColor(SharedPreferenceKeys.backgroundColorLine);
      _backgroundColorDeactiveButton = _loadColor(SharedPreferenceKeys.backgroundColorDeactiveButton);
      _titleColorDeactiveButton = _loadColor(SharedPreferenceKeys.titleColorDeactiveButton);
      _backgroundColorCaptureDocumentScreen = _loadColor(SharedPreferenceKeys.backgroundColorCaptureDocumentScreen);
      _backgroundColorCaptureFaceScreen = _loadColor(SharedPreferenceKeys.backgroundColorCaptureFaceScreen);
      _textColorNoticeFace = _loadColor(SharedPreferenceKeys.textColorNoticeFace);
      _effectColorNoticeInvalidFace = _loadColor(SharedPreferenceKeys.effectColorNoticeInvalidFace);
      _colorContentFaceEffect = _loadColor(SharedPreferenceKeys.colorContentFaceEffect);
      _effectColorNoticeValidDocument = _loadColor(SharedPreferenceKeys.effectColorNoticeValidDocument);
      _effectColorNoticeInvalidDocument = _loadColor(SharedPreferenceKeys.effectColorNoticeInvalidDocument);
      _textColorNoticeValidDocument = _loadColor(SharedPreferenceKeys.textColorNoticeValidDocument);
      _textColorNoticeInvalidDocument = _loadColor(SharedPreferenceKeys.textColorNoticeInvalidDocument);
      _tintColorButtonCapture = _loadColor(SharedPreferenceKeys.tintColorButtonCapture);
      _textColorContentPopup = _loadColor(SharedPreferenceKeys.textColorContentPopup);
    });
  }

    Color? _loadColor(String key) {
    final value = SharedPreferenceService.instance.getInt(key);
    return value != null ? Color(value) : null;
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
        _saveColor(SharedPreferenceKeys.contentColorHeaderBar, _contentColorHeaderBar),
        _saveColor(SharedPreferenceKeys.backgroundColorHeaderBar, _backgroundColorHeaderBar),
        _saveColor(SharedPreferenceKeys.titleColorMain, _titleColorMain),
        _saveColor(SharedPreferenceKeys.backgroundColorMainScreen, _backgroundColorMainScreen),
        _saveColor(SharedPreferenceKeys.backgroundColorActiveButton, _backgroundColorActiveButton),
        _saveColor(SharedPreferenceKeys.titleColorActiveButton, _titleColorActiveButton),
        _saveColor(SharedPreferenceKeys.effectColorNoticeFace, _effectColorNoticeFace),
        _saveColor(SharedPreferenceKeys.backgroundColorPopup, _backgroundColorPopup),
        _saveColor(SharedPreferenceKeys.backgroundColorBorderCaptureFace, _backgroundColorBorderCaptureFace),
        _saveColor(SharedPreferenceKeys.textColorContentMain, _textColorContentMain),
        _saveColor(SharedPreferenceKeys.backgroundColorLine, _backgroundColorLine),
        _saveColor(SharedPreferenceKeys.backgroundColorDeactiveButton, _backgroundColorDeactiveButton),
        _saveColor(SharedPreferenceKeys.titleColorDeactiveButton, _titleColorDeactiveButton),
        _saveColor(SharedPreferenceKeys.backgroundColorCaptureDocumentScreen, _backgroundColorCaptureDocumentScreen),
        _saveColor(SharedPreferenceKeys.backgroundColorCaptureFaceScreen, _backgroundColorCaptureFaceScreen),
        _saveColor(SharedPreferenceKeys.textColorNoticeFace, _textColorNoticeFace),
        _saveColor(SharedPreferenceKeys.effectColorNoticeInvalidFace, _effectColorNoticeInvalidFace),
        _saveColor(SharedPreferenceKeys.colorContentFaceEffect, _colorContentFaceEffect),
        _saveColor(SharedPreferenceKeys.effectColorNoticeValidDocument, _effectColorNoticeValidDocument),
        _saveColor(SharedPreferenceKeys.effectColorNoticeInvalidDocument, _effectColorNoticeInvalidDocument),
        _saveColor(SharedPreferenceKeys.textColorNoticeValidDocument, _textColorNoticeValidDocument),
        _saveColor(SharedPreferenceKeys.textColorNoticeInvalidDocument, _textColorNoticeInvalidDocument),
        _saveColor(SharedPreferenceKeys.tintColorButtonCapture, _tintColorButtonCapture),
        _saveColor(SharedPreferenceKeys.textColorContentPopup, _textColorContentPopup),
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
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nội dung header',
                      color: _contentColorHeaderBar,
                      onColorChanged: (color) => setState(() => _contentColorHeaderBar = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền header',
                      color: _backgroundColorHeaderBar,
                      onColorChanged: (color) => setState(() => _backgroundColorHeaderBar = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu tiêu đề chính',
                      color: _titleColorMain,
                      onColorChanged: (color) => setState(() => _titleColorMain = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền màn hình chính',
                      color: _backgroundColorMainScreen,
                      onColorChanged: (color) => setState(() => _backgroundColorMainScreen = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền nút active',
                      color: _backgroundColorActiveButton,
                      onColorChanged: (color) => setState(() => _backgroundColorActiveButton = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu chữ nút active',
                      color: _titleColorActiveButton,
                      onColorChanged: (color) => setState(() => _titleColorActiveButton = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu hiệu ứng face',
                      color: _effectColorNoticeFace,
                      onColorChanged: (color) => setState(() => _effectColorNoticeFace = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu viền khung chụp face',
                      color: _backgroundColorBorderCaptureFace,
                      onColorChanged: (color) => setState(() => _backgroundColorBorderCaptureFace = color),
                    ),

                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền popup',
                      color: _backgroundColorPopup,
                      onColorChanged: (color) => setState(() => _backgroundColorPopup = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text nội dung chính',
                      color: _textColorContentMain,
                      onColorChanged: (color) => setState(() => _textColorContentMain = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu đường kẻ ngăn cách',
                      color: _backgroundColorLine,
                      onColorChanged: (color) => setState(() => _backgroundColorLine = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền nút inactive',
                      color: _backgroundColorDeactiveButton,
                      onColorChanged: (color) => setState(() => _backgroundColorDeactiveButton = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text nút inactive',
                      color: _titleColorDeactiveButton,
                      onColorChanged: (color) => setState(() => _titleColorDeactiveButton = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền màn chụp giấy tờ',
                      color: _backgroundColorCaptureDocumentScreen,
                      onColorChanged: (color) => setState(() => _backgroundColorCaptureDocumentScreen = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nền màn chụp face',
                      color: _backgroundColorCaptureFaceScreen,
                      onColorChanged: (color) => setState(() => _backgroundColorCaptureFaceScreen = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text cảnh báo face',
                      color: _textColorNoticeFace,
                      onColorChanged: (color) => setState(() => _textColorNoticeFace = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu hiệu ứng face không hợp lệ',
                      color: _effectColorNoticeInvalidFace,
                      onColorChanged: (color) => setState(() => _effectColorNoticeInvalidFace = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nội dung viền oval',
                      color: _colorContentFaceEffect,
                      onColorChanged: (color) => setState(() => _colorContentFaceEffect = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu hiệu ứng giấy tờ hợp lệ',
                      color: _effectColorNoticeValidDocument,
                      onColorChanged: (color) => setState(() => _effectColorNoticeValidDocument = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu hiệu ứng giấy tờ không hợp lệ',
                      color: _effectColorNoticeInvalidDocument,
                      onColorChanged: (color) => setState(() => _effectColorNoticeInvalidDocument = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text giấy tờ hợp lệ',
                      color: _textColorNoticeValidDocument,
                      onColorChanged: (color) => setState(() => _textColorNoticeValidDocument = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text giấy tờ không hợp lệ',
                      color: _textColorNoticeInvalidDocument,
                      onColorChanged: (color) => setState(() => _textColorNoticeInvalidDocument = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu nút chụp ảnh',
                      color: _tintColorButtonCapture,
                      onColorChanged: (color) => setState(() => _tintColorButtonCapture = color),
                    ),
                    
                    _buildColorPicker(
                      context: context,
                      title: 'Màu text popup',
                      color: _textColorContentPopup,
                      onColorChanged: (color) => setState(() => _textColorContentPopup = color),
                    ),
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

  Widget _buildSelectionField(
    String title,
    String currentValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: context.textTheme.p),
        Row(
          children: [
            // Image preview - only show if image is selected
            if (currentValue.isNotEmpty)
              Container(
                constraints: BoxConstraints(maxWidth: 100, maxHeight: 60),
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    currentValue,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Center(
                      child: Icon(Icons.broken_image, size: 30, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ShadSelect<String>(
                selectedOptionBuilder:
                    (context, value) => Text(value.split('/').last),
                placeholder: const Text('Chọn ảnh hướng dẫn'),
                options: [
                  const ShadOption(value: '', child: Text('Mặc định SDK')),
                  ..._availableAssets.map(
                    (asset) => ShadOption(
                      value: asset,
                      child: Row(
                        children: [
                          Image.asset(
                            asset,
                            width: 30,
                            height: 30,
                            errorBuilder:
                                (c, e, s) => const Icon(Icons.image, size: 30),
                          ),
                          const SizedBox(width: 10),
                          Text(asset.split('/').last),
                        ],
                      ),
                    ),
                  ),
                ],
                initialValue: currentValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> _saveColor(String key, Color? color) async {
  if (color != null) {
    await SharedPreferenceService.instance.setInt(key, color.toARGB32());
  } else {
    await SharedPreferenceService.instance.remove(key);
  }
}

Widget _buildColorPicker({
  required BuildContext context,
  required String title,
  required Color? color,
  required Function(Color?) onColorChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(title, style: context.textTheme.p),
          ),
          if (color != null)
            TextButton(
              onPressed: () => onColorChanged(null),
              child: Text('Xóa'),
            ),
        ],
      ),
      InkWell(
        onTap: () => _showColorPickerDialog(context, color, onColorChanged),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.border, width: 1),
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Center(
            child: Text(
              color != null
                  ? '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}'
                  : 'Chọn màu',
              style: TextStyle(
                color:
                    color != null
                        ? (color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)
                        : context.colorScheme.mutedForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void _showColorPickerDialog(
  BuildContext context,
  Color? currentColor,
  Function(Color?) onColorChanged,
) {
  Color pickerColor = currentColor ?? Colors.blue;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chọn màu'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) => pickerColor = color,
            pickerAreaHeightPercent: 0.8,
            displayThumbColor: true,
            enableAlpha: true,
            labelTypes: const [ ColorLabelType.hex, ColorLabelType.rgb, ColorLabelType.hsv, ColorLabelType.hsl ],
            hexInputBar: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              onColorChanged(pickerColor);
              Navigator.of(context).pop();
            },
            child: Text('Chọn'),
          ),
        ],
      );
    },
  );
}

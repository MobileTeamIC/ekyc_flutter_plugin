import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_ekyc/flutter_plugin_ic_ekyc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../service/shared_preference.dart';
import '../theme/context.dart';

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
  final TextEditingController _numberTimesRetryScanQRCodeController =
      TextEditingController();
  final TextEditingController _timeoutQRCodeFlowController =
      TextEditingController();
  bool _isLoading = false;

  LanguageSdk _languageMode = LanguageSdk.icekyc_vi;
  ModeButtonHeaderBar _modeButtonHeaderBar = ModeButtonHeaderBar.leftButton;
  bool _isShowLogo = false;
  bool _isShowTutorial = false;
  bool _isEnableGotIt = false;


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
    _languageMode =
        SharedPreferenceService.instance.getBool(
              SharedPreferenceKeys.isViLanguageMode,
              defaultValue: true,
            )
            ? LanguageSdk.icekyc_vi
            : LanguageSdk.icekyc_en;

    _modeButtonHeaderBar =
        SharedPreferenceService.instance.getString(
                  SharedPreferenceKeys.modeButtonHeaderBar,
                ) ==
                ModeButtonHeaderBar.leftButton.name
            ? ModeButtonHeaderBar.leftButton
            : ModeButtonHeaderBar.rightButton;
    _isShowLogo = SharedPreferenceService.instance.getBool(
      SharedPreferenceKeys.isShowLogo,
      defaultValue: false,
    );
    _isShowTutorial = SharedPreferenceService.instance.getBool(
      SharedPreferenceKeys.isShowTutorial,
      defaultValue: false,
    );
    _isEnableGotIt = SharedPreferenceService.instance.getBool(
      SharedPreferenceKeys.isEnableGotIt,
      defaultValue: false,
    );

    // QR Code configuration: null means not set
    final retryCount = SharedPreferenceService.instance.getInt(
      SharedPreferenceKeys.numberTimesRetryScanQRCode,
    );
    _numberTimesRetryScanQRCodeController.text = retryCount?.toString() ?? '';

    final timeout = SharedPreferenceService.instance.getInt(
      SharedPreferenceKeys.timeoutQRCodeFlow,
    );
    _timeoutQRCodeFlowController.text = timeout?.toString() ?? '';

  
  }



  @override
  void dispose() {
    _accessTokenController.dispose();
    _tokenIdController.dispose();
    _tokenKeyController.dispose();
    _baseUrlController.dispose();
    _numberTimesRetryScanQRCodeController.dispose();
    _timeoutQRCodeFlowController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save basic settings
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
          _languageMode == LanguageSdk.icekyc_vi,
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.modeButtonHeaderBar,
          _modeButtonHeaderBar.name,
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isShowLogo,
          _isShowLogo,
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isShowTutorial,
          _isShowTutorial,
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isEnableGotIt,
          _isEnableGotIt,
        ),
      ]);

      // Handle QR Code configuration: save null by removing key if empty
      final retryText = _numberTimesRetryScanQRCodeController.text.trim();
      if (retryText.isEmpty) {
        await SharedPreferenceService.instance.remove(
          SharedPreferenceKeys.numberTimesRetryScanQRCode,
        );
      } else {
        final retryValue = int.tryParse(retryText);
        if (retryValue != null) {
          await SharedPreferenceService.instance.setInt(
            SharedPreferenceKeys.numberTimesRetryScanQRCode,
            retryValue,
          );
        }
      }

      final timeoutText = _timeoutQRCodeFlowController.text.trim();
      if (timeoutText.isEmpty) {
        await SharedPreferenceService.instance.remove(
          SharedPreferenceKeys.timeoutQRCodeFlow,
        );
      } else {
        final timeoutValue = int.tryParse(timeoutText);
        if (timeoutValue != null) {
          await SharedPreferenceService.instance.setInt(
            SharedPreferenceKeys.timeoutQRCodeFlow,
            timeoutValue,
          );
        }
      }

      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã lưu cài đặt thành công'),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cài đặt', style: context.textTheme.h3)),
        body: SafeArea(
          child: Column(
            spacing: 16,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text('Hiển thị Logo', style: context.textTheme.p),
                            Spacer(),
                            ShadSwitch(
                              value: _isShowLogo,
                              onChanged: (v) => setState(() => _isShowLogo = v),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Hiển thị Tutorial',
                              style: context.textTheme.p,
                            ),
                            Spacer(),
                            ShadSwitch(
                              value: _isShowTutorial,
                              onChanged:
                                  (v) => setState(() => _isShowTutorial = v),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Hiển thị Got It', style: context.textTheme.p),
                            Spacer(),
                            ShadSwitch(
                              value: _isEnableGotIt,
                              onChanged:
                                  (v) => setState(() => _isEnableGotIt = v),
                            ),
                          ],
                        ),
                        _titleAndWidget(
                          'Mode Button Header Bar',
                          ShadSelect<String>(
                            selectedOptionBuilder:
                                (context, value) => Text(value),
                            placeholder: const Text(' Mode Button Header Bar'),
                            options: [
                              ShadOption(
                                value: ModeButtonHeaderBar.leftButton.name,
                                child: Text(
                                  ModeButtonHeaderBar.leftButton.name,
                                ),
                              ),
                              ShadOption(
                                value: ModeButtonHeaderBar.rightButton.name,
                                child: Text(
                                  ModeButtonHeaderBar.rightButton.name,
                                ),
                              ),
                            ],
                            onChanged:
                                (value) => setState(
                                  () =>
                                      _modeButtonHeaderBar = ModeButtonHeaderBar
                                          .values
                                          .firstWhere((e) => e.name == value),
                                ),
                          ),
                        ),

                        // Language mode
                        _titleAndWidget(
                          'Ngôn ngữ',
                          ShadSelect<String>(
                            selectedOptionBuilder:
                                (context, value) => Text(
                                  value == LanguageSdk.icekyc_vi.name
                                      ? 'Tiếng Việt'
                                      : 'Tiếng Anh',
                                ),
                            placeholder: const Text(' Chọn Ngôn ngữ'),
                            onChanged:
                                (value) => setState(
                                  () =>
                                      _languageMode = LanguageSdk.values
                                          .firstWhere((e) => e.name == value),
                                ),
                            initialValue: _languageMode.name,
                            options: [
                              ShadOption(
                                value: LanguageSdk.icekyc_vi.name,
                                child: Text('Tiếng Việt'),
                              ),
                              ShadOption(
                                value: LanguageSdk.icekyc_en.name,
                                child: Text('Tiếng Anh'),
                              ),
                            ],
                          ),
                        ),

                        // Base URL
                        _titleAndTextFormField(
                          id: 'base_url',
                          title: 'Base URL',
                          placeholder: 'Nhập Base URL',
                          controller: _baseUrlController,
                        ),

                        // Access Token
                        _titleAndTextFormField(
                          id: 'access_token',
                          title: 'Access Token',
                          placeholder: 'Nhập Access Token',
                          controller: _accessTokenController,
                          isTextArea: true,
                        ),

                        // Token ID
                        _titleAndTextFormField(
                          id: 'token_id',
                          title: 'Token ID',
                          placeholder: 'Nhập Token ID',
                          controller: _tokenIdController,
                        ),

                        // Token Key
                        _titleAndTextFormField(
                          id: 'token_key',
                          title: 'Token Key',
                          placeholder: 'Nhập Token Key',
                          controller: _tokenKeyController,
                        ),

                        // QR Code Configuration
                        _titleAndNumberFormField(
                          id: 'number_times_retry_scan_qrcode',
                          title: 'Số lần thử lại quét QR Code',
                          placeholder: 'Để trống để dùng mặc định SDK',
                          controller: _numberTimesRetryScanQRCodeController,
                        ),

                        _titleAndNumberFormField(
                          id: 'timeout_qrcode_flow',
                          title: 'Timeout QR Code Flow (giây)',
                          placeholder: 'Để trống để dùng mặc định SDK',
                          controller: _timeoutQRCodeFlowController,
                        ),

                        // Color configurations
                        Divider(height: 32),
                        Text('Cấu hình màu sắc', style: context.textTheme.h4),
                        SizedBox(height: 8),

                      
                      ],
                    ),
                  ),
                ),
              ),
              // Save button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ShadButton(
                  onPressed: _isLoading ? null : _saveSettings,
                  backgroundColor: context.colorScheme.primary,
                  width: double.infinity,
                  height: 48,
                  child: Text(
                    _isLoading ? 'Đang lưu...' : 'Lưu cài đặt',
                    style: context.textTheme.large,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _titleAndTextFormField({
    required String id,
    required String title,
    required String placeholder,
    required TextEditingController controller,
    bool isTextArea = false,
  }) {
    if (isTextArea) {
      return ShadTextareaFormField(
        id: id,
        label: Text(title),
        resizable: true,
        maxHeight: 400,
        minHeight: 100,
        placeholder: Text(placeholder),
        controller: controller,
        trailing: Row(
          spacing: 8,
          children: [
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handlePaste(context, controller),
              icon: const Icon(LucideIcons.clipboardPaste),
            ),
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handleCopy(controller.text),
              icon: const Icon(LucideIcons.copy),
            ),
          ],
        ),
      );
    } else {
      return ShadInputFormField(
        id: id,
        label: Text(title),
        placeholder: Text(placeholder),
        controller: controller,
        trailing: Row(
          spacing: 8,
          children: [
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handlePaste(context, controller),
              icon: const Icon(LucideIcons.clipboardPaste),
            ),
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handleCopy(controller.text),
              icon: const Icon(LucideIcons.copy),
            ),
          ],
        ),
      );
    }
  }

  _titleAndWidget(String title, Widget widget) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        widget,
      ],
    );
  }

  _titleAndNumberFormField({
    required String id,
    required String title,
    required String placeholder,
    required TextEditingController controller,
  }) {
    return ShadInputFormField(
      id: id,
      label: Text(title),
      placeholder: Text(placeholder),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^-?\d*'),
        ), // Allow negative numbers
      ],
    );
  }

  //handle
  _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ShadToaster.of(context).show(
      ShadToast(
        title: Text('Đã copy vào clipboard'),
        titleStyle: context.textTheme.p.copyWith(color: Colors.white),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }

  _handlePaste(BuildContext context, TextEditingController controller) async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboard != null) {
      controller.text = clipboard.text ?? '';
      if (context.mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã paste vào clipboard'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.primary,
          ),
        );
      }
    }
  }
}

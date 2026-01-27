import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_ekyc/flutter_plugin_ic_ekyc.dart';
import 'package:flutter_plugin_ic_ekyc_example/service/shared_preference.dart';
import 'package:flutter_plugin_ic_ekyc_example/view/config_ui_screen.dart';
import 'package:flutter_plugin_ic_ekyc_example/view/log_screen.dart';
import 'package:flutter_plugin_ic_ekyc_example/view/setting_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../theme/context.dart';

class EkycScreen extends StatefulWidget {
  const EkycScreen({super.key});

  @override
  State<EkycScreen> createState() => _EkycScreenState();
}

class _EkycScreenState extends State<EkycScreen> {
  String _accessToken = '';
  String _tokenId = '';
  String _tokenKey = '';
  String _baseUrl = '';
  LanguageSdk _language = LanguageSdk.icekyc_vi;
  ModeButtonHeaderBar _modeButtonHeaderBar = ModeButtonHeaderBar.leftButton;
  bool _isShowLogo = false;
  bool _isShowTutorial = false;
  bool _isEnableGotIt = false;
  int? _numberTimesRetryScanQRCode;
  int? _timeoutQRCodeFlow;
  String? _imageTutorialQRCode;
  String? _imageTutorialFront;
  String? _imageTutorialBack;
  String? _imageTutorialBlur;
  String? _imageTutorialLostAngle;
  String? _imageTutorialGlare;
  String? _logo;
  String? _logoFaceOval;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _accessToken = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessToken,
    );
    _tokenId = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenId,
    );
    _tokenKey = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKey,
    );
    _baseUrl = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.baseUrl,
    );
    _language =
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
    
    // QR Code configuration: pass null directly to SDK if not set
    _numberTimesRetryScanQRCode = SharedPreferenceService.instance.getInt(
      SharedPreferenceKeys.numberTimesRetryScanQRCode,
    );
    
    _timeoutQRCodeFlow = SharedPreferenceService.instance.getInt(
      SharedPreferenceKeys.timeoutQRCodeFlow,
    );

    _imageTutorialQRCode = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialQRCode);
    _imageTutorialFront = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialFront);
    _imageTutorialBack = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialBack);
    _imageTutorialBlur = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialBlur);
    _imageTutorialLostAngle = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialLostAngle);
    _imageTutorialGlare = SharedPreferenceService.instance.getString(SharedPreferenceKeys.imageTutorialGlare);
    _logo = SharedPreferenceService.instance.getString(SharedPreferenceKeys.logo);
    _logoFaceOval = SharedPreferenceService.instance.getString(SharedPreferenceKeys.logoFaceOval);
  }

  /// Navigate to Log Screen
  void _navigate(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LogScreen(json: json)),
      );
    }
  }

  // MARK: - eKYC Flows
  Future<void> _fullEkyc() async {
    try {
      final config = ICEkycPresets.fullEkyc(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        changeBaseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        isShowTutorial: _isShowTutorial,
        isEnableGotIt: _isEnableGotIt,
        documentType: DocumentType.identityCard,
        versionSdk: VersionSdk.proOval,
        checkLivenessFace: LivenessFaceMode.standard,
        validateDocumentType: ValidateDocumentType.basic,
        imageTutorialFront: _imageTutorialFront?.isEmpty ?? true ? null : _imageTutorialFront,
        imageTutorialBack: _imageTutorialBack?.isEmpty ?? true ? null : _imageTutorialBack,
        imageTutorialBlur: _imageTutorialBlur?.isEmpty ?? true ? null : _imageTutorialBlur,
        imageTutorialLostAngle: _imageTutorialLostAngle?.isEmpty ?? true ? null : _imageTutorialLostAngle,
        imageTutorialGlare: _imageTutorialGlare?.isEmpty ?? true ? null : _imageTutorialGlare,
        logo: _logo?.isEmpty ?? true ? null : _logo,
        logoFaceOval: _logoFaceOval?.isEmpty ?? true ? null : _logoFaceOval,
        widthLogo: 148.0,
        heightLogo: 20.0,
      );
      _navigate(await ICEkyc.instance.startEkycFull(config));
    } on PlatformException catch (e) {
      if (e.code == EkycStatus.cancelled.value) {
        _showError("User cancelled eKYC flow with last step: ${e.message}");
      } else {
        _showError("Error: ${e.code} - ${e.message}");
      }
    }
  }

  Future<void> _ocrOnly() async {
    try {
      final config = ICEkycPresets.ocrOnly(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        changeBaseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        isShowTutorial: _isShowTutorial,
        isEnableGotIt: _isEnableGotIt,
        documentType: DocumentType.identityCard,
        validateDocumentType: ValidateDocumentType.basic,
        imageTutorialFront: _imageTutorialFront?.isEmpty ?? true ? null : _imageTutorialFront,
        imageTutorialBack: _imageTutorialBack?.isEmpty ?? true ? null : _imageTutorialBack,
        logo: _logo?.isEmpty ?? true ? null : _logo,
        widthLogo: 148.0,
        heightLogo: 20.0,
      );
      _navigate(await ICEkyc.instance.startEkycOcr(config));
    } on PlatformException catch (e) {
      _showError("Error: ${e.code} - ${e.message}");
    }
  }

  Future<void> _ocrFront() async {
    try {
      final config = ICEkycPresets.ocrFront(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        changeBaseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        isShowTutorial: _isShowTutorial,
        isEnableGotIt: _isEnableGotIt,
        documentType: DocumentType.identityCard,
        validateDocumentType: ValidateDocumentType.basic,
        logo: _logo?.isEmpty ?? true ? null : _logo,
        widthLogo: 148.0,
        heightLogo: 20.0,
        imageTutorialBlur: _imageTutorialBlur?.isEmpty ?? true ? null : _imageTutorialBlur,
        imageTutorialLostAngle: _imageTutorialLostAngle?.isEmpty ?? true ? null : _imageTutorialLostAngle,
        imageTutorialGlare: _imageTutorialGlare?.isEmpty ?? true ? null : _imageTutorialGlare,
        imageTutorialFront: _imageTutorialFront?.isEmpty ?? true ? null : _imageTutorialFront,

      );
      _navigate(await ICEkyc.instance.startEkycOcrFront(config));
    } on PlatformException catch (e) {
      if (e.code == EkycStatus.cancelled.value) {
        _showError("User cancelled eKYC flow with last step: ${e.message}");
      } else {
        _showError("Error: ${e.code} - ${e.message}");
      }
    }
  }

  Future<void> _faceVerification() async {
    try {
      final config = ICEkycPresets.faceVerification(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        isShowTutorial: _isShowTutorial,
        isEnableGotIt: _isEnableGotIt,
        versionSdk: VersionSdk.proOval,
        checkLivenessFace: LivenessFaceMode.standard,
        logo: _logo?.isEmpty ?? true ? null : _logo,
        logoFaceOval: _logoFaceOval?.isEmpty ?? true ? null : _logoFaceOval,
        widthLogo: 148.0,
        heightLogo: 20.0,
        imageTutorialFront: _imageTutorialFront?.isEmpty ?? true ? null : _imageTutorialFront,
        imageTutorialBack: _imageTutorialBack?.isEmpty ?? true ? null : _imageTutorialBack,
        imageTutorialBlur: _imageTutorialBlur?.isEmpty ?? true ? null : _imageTutorialBlur,
        imageTutorialLostAngle: _imageTutorialLostAngle?.isEmpty ?? true ? null : _imageTutorialLostAngle,
        imageTutorialGlare: _imageTutorialGlare?.isEmpty ?? true ? null : _imageTutorialGlare,
      );
      _navigate(await ICEkyc.instance.startEkycFace(config));
    } on PlatformException catch (e) {
      _showError("Error: ${e.code} - ${e.message}");
    }
  }

  Future<void> _scanQRCode() async {
    try {
      final config = ICEkycPresets.scanQRCode(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        isShowTutorial: _isShowTutorial,
        isEnableGotIt: _isEnableGotIt,
        numberTimesRetryScanQRCode: _numberTimesRetryScanQRCode,
        timeoutQRCodeFlow: _timeoutQRCodeFlow,
        imageTutorialQRCode: _imageTutorialQRCode?.isEmpty ?? true ? null : _imageTutorialQRCode,
        logo: _logo?.isEmpty ?? true ? null : _logo,
        widthLogo: 148.0,
        heightLogo: 20.0,

        imageTutorialFront: _imageTutorialFront?.isEmpty ?? true ? null : _imageTutorialFront,
        imageTutorialBack: _imageTutorialBack?.isEmpty ?? true ? null : _imageTutorialBack,
        imageTutorialBlur: _imageTutorialBlur?.isEmpty ?? true ? null : _imageTutorialBlur,
        imageTutorialLostAngle: _imageTutorialLostAngle?.isEmpty ?? true ? null : _imageTutorialLostAngle,
        imageTutorialGlare: _imageTutorialGlare?.isEmpty ?? true ? null : _imageTutorialGlare,
      );
      _navigate(await ICEkyc.instance.startEkycScanQRCode(config));
    } on PlatformException catch (e) {
      if (e.code == EkycStatus.cancelled.value) {
        _showError("User cancelled eKYC flow with last step: ${e.message}");
      } else {
        _showError("Error: ${e.code} - ${e.message}");
      }
    }
  }

  // MARK: - Error UI
  void _showError(String message) {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        title: Text(message),
        titleStyle: context.theme.textTheme.p.copyWith(color: Colors.white),
        backgroundColor: context.theme.colorScheme.destructive,
      ),
    );
  }

  // MARK: - UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                ).then((_) => loadData());
              },
              tooltip: 'Cài đặt',
            ),
            IconButton(
              icon: const Icon(Icons.palette),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfigUiScreen(),
                  ),
                ).then((_) => loadData());
              },
              tooltip: 'Cấu hình UI',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("eKYC SDK", style: context.textTheme.h1),
              const SizedBox(height: 16),
              _ActionCard(
                icon: Icons.badge,
                title: "eKYC Đầy Đủ",
                description1: "Thực hiện OCR giấy tờ (mặt trước + mặt sau)",
                description2: "Xác thực khuôn mặt với liveness detection",
                onTap: () async => _fullEkyc(),
              ),
              _ActionCard(
                icon: Icons.credit_card,
                title: "OCR Giấy Tờ",
                description1: "Đọc thông tin từ CMND/CCCD/Hộ chiếu",
                description2: "Chụp cả mặt trước và mặt sau",
                onTap: () async => _ocrOnly(),
              ),
              _ActionCard(
                icon: Icons.document_scanner,
                title: "OCR Mặt Trước",
                description1: "Chỉ đọc mặt trước giấy tờ",
                description2: "Trích xuất thông tin cơ bản",
                onTap: () async => _ocrFront(),
              ),
              _ActionCard(
                icon: Icons.face,
                title: "Xác Thực Khuôn Mặt",
                description1: "Chụp ảnh khuôn mặt với oval guide",
                description2: "Kiểm tra liveness và masked face",
                onTap: () async => _faceVerification(),
              ),
              _ActionCard(
                icon: Icons.qr_code_scanner,
                title: "Quét Mã QR",
                description1: "Quét mã QR trên CMND/CCCD/Hộ chiếu",
                description2: "Lấy thông tin từ QR code",
                onTap: () async => _scanQRCode(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================
/// REUSABLE WIDGETS
/// ============================
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description1;
  final String description2;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description1,
    required this.description2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT ICON
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
              ),

              const SizedBox(width: 16),

              // TEXT CONTENT (EXPANDED)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // DESCRIPTION 1
                    _iconTextRow(context, theme, description1),

                    const SizedBox(height: 6),

                    // DESCRIPTION 2
                    _iconTextRow(context, theme, description2),
                  ],
                ),
              ),

              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconTextRow(BuildContext context, ThemeData theme, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 6),

        Expanded(
          child: Text(
            text,
            style: context.textTheme.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

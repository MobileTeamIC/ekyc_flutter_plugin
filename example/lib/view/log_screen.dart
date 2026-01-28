import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_ekyc/flutter_plugin_ic_ekyc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../theme/context.dart';

class LogScreen extends StatefulWidget {
  final Map<String, dynamic> json;

  const LogScreen({super.key, required this.json});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả eKYC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_all),
            onPressed: () => _copyAllToClipboard(context),
            tooltip: 'Sao chép tất cả',
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Đóng',
          ),
        ],
      ),
      body:
          widget.json.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 64,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không có dữ liệu',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                children: [
                  // Display images if available
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageFrontFull] as String?,
                    'Ảnh mặt trước',
                  ),
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageBackFull] as String?,
                    'Ảnh mặt sau',
                  ),
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageFaceFull] as String?,
                    'Ảnh khuôn mặt',
                  ),
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageFaceFarFull]
                        as String?,
                    'Ảnh khuôn mặt xa',
                  ),
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageFaceNearFull]
                        as String?,
                    'Ảnh khuôn mặt gần',
                  ),
                  _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageFaceScan3D] as String?,
                    'Ảnh 3D Scan',
                  ),

                   _buildSafeImage(
                    widget.json[ICEkycKeyResult.pathImageQRCodeFull] as String?,
                    'Ảnh QR code full',
                  ),

                  // Display data fields
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'CROP PARAM',
                    content: widget.json[ICEkycKeyResult.cropParam],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.credit_card,
                    title: 'Client Session Result',
                    content: widget.json[ICEkycKeyResult.clientSessionResult],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.image,
                    title: 'Path Image Front Full',
                    content: widget.json[ICEkycKeyResult.pathImageFrontFull],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.image,
                    title: 'Path Image Back Full',
                    content: widget.json[ICEkycKeyResult.pathImageBackFull],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.face,
                    title: 'Path Image Face Full',
                    content: widget.json[ICEkycKeyResult.pathImageFaceFull],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.face,
                    title: 'Path Image Face Far Full',
                    content: widget.json[ICEkycKeyResult.pathImageFaceFarFull],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.face,
                    title: 'Path Image Face Near Full',
                    content: widget.json[ICEkycKeyResult.pathImageFaceNearFull],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.threed_rotation,
                    title: 'Path Face Scan 3D',
                    content: widget.json[ICEkycKeyResult.pathImageFaceScan3D],
                  ),
                  const SizedBox(height: 12),
                  
                  // QR Code Results
                  _buildLogItem(
                    context,
                    icon: Icons.qr_code,
                    title: 'QR Code Result',
                    content: widget.json[ICEkycKeyResult.qrCodeResult],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.qr_code_scanner,
                    title: 'QR Code Result Detail (Map)',
                    content: _formatMapToJson(widget.json[ICEkycKeyResult.qrCodeResultDetail]),
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.sync_problem,
                    title: 'Retry QR Code Result (List)',
                    content: _listMapToJson(widget.json[ICEkycKeyResult.retryQRCodeResult] as List? ?? []),
                  ),
                ],
              ),
    );
  }

  /// Helper method to format Map as pretty JSON string
  String? _formatMapToJson(dynamic data) {
    if (data == null) return null;
    
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  String? _listMapToJson(List list) {
    if (list.isEmpty) return null;
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(list);
    } catch (e) {
      return list.toString();
    }
  }

  Widget _buildSafeImage(String? path, String label) {
    if (path == null || path.isEmpty) {
      return const SizedBox.shrink();
    }

    File file;
    try {
      if (path.startsWith('file://')) {
        file = File(Uri.parse(path).toFilePath());
      } else {
        file = File(path);
      }
    } catch (e) {
      return const SizedBox.shrink();
    }

    // Check if file exists
    if (!file.existsSync()) {
      return const SizedBox.shrink();
    }

    // Read file as bytes
    Uint8List imageBytes;
    try {
      imageBytes = file.readAsBytesSync();
    } catch (e) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Image.memory(
          imageBytes,
          gaplessPlayback: true,
          key: ValueKey(DateTime.now().millisecondsSinceEpoch),
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String? content) async {
    if (content != null && content.trim().isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: content));
      if (context.mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã sao chép'),
            titleStyle: context.theme.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.theme.colorScheme.primary,
          ),
        );
      }
    }
  }

  Widget _buildLogItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? content,
  }) {
    if (content == null || content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    Map<String, dynamic>? parsedJson;
    String displayText;
    bool isJson = false;

    try {
      parsedJson = jsonDecode(content);
      isJson = true;
      // Format JSON with indentation
      const encoder = JsonEncoder.withIndent('  ');
      displayText = encoder.convert(parsedJson);
    } catch (e) {
      displayText = content;
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _copyToClipboard(context, content),
                  icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                  label: const Text(
                    'Sao chép',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SelectableText(
              displayText,
              style: TextStyle(
                fontFamily: isJson ? 'monospace' : null,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copyAllToClipboard(BuildContext context) async {
    final buffer = StringBuffer();
    buffer.writeln('json: ${widget.json}');
    buffer.writeln('--------------------------------');
    final keys = [
      ICEkycKeyResult.cropParam,
      ICEkycKeyResult.pathImageFrontFull,
      ICEkycKeyResult.pathImageBackFull,
      ICEkycKeyResult.pathImageFaceFull,
      ICEkycKeyResult.pathImageFaceFarFull,
      ICEkycKeyResult.pathImageFaceNearFull,
      ICEkycKeyResult.pathImageFaceScan3D,
      ICEkycKeyResult.clientSessionResult,
      ICEkycKeyResult.qrCodeResult,
      ICEkycKeyResult.qrCodeResultDetail,
      ICEkycKeyResult.retryQRCodeResult,
    ];

    for (final key in keys) {
      final content = widget.json[key];
      if (content != null && content.toString().trim().isNotEmpty) {
        buffer.writeln('$key:');
        buffer.writeln(content);
        buffer.writeln('\n---\n');
      }
    }

    if (buffer.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: buffer.toString()));
      if (context.mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã sao chép tất cả'),
            titleStyle: context.theme.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.theme.colorScheme.primary,
          ),
        );
      }
    }
  }
}

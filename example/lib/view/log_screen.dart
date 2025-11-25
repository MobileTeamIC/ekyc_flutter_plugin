import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_ekyc/flutter_plugin_ic_ekyc.dart';

class LogScreen extends StatelessWidget {
  final Map<String, dynamic> json;

  const LogScreen({
    super.key,
    required this.json,
  });

  bool get shouldShowCopyAll => json.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả eKYC'),
        actions: [
          if (shouldShowCopyAll)
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
      body: json.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
              padding: const EdgeInsets.all(8),
              children: [
                 _buildSafeImage(
                    json[ICEkycKeyResult.pathImageFrontFull]
                  ),
                  _buildSafeImage(
                    json[ICEkycKeyResult.pathImageBackFull],
                  ),
                  _buildSafeImage(
                    json[ICEkycKeyResult.pathImageFaceFull],
                  ),
                  _buildSafeImage(
                    json[ICEkycKeyResult.pathImageFaceFarFull],
                  ),
                  _buildSafeImage(
                    json[ICEkycKeyResult.pathImageFaceNearFull],
                  ),
                  _buildLogItem(
                  context,
                  icon: Icons.face_retouching_natural,
                  title: 'Client Session Result',
                  content: json[ICEkycKeyResult.clientSessionResult],
                ),
                const SizedBox(height: 12),
                _buildLogItem(
                  context,
                  icon: Icons.document_scanner,
                  title: 'Crop Param',
                  content: json[ICEkycKeyResult.cropParam],
                ),
                const SizedBox(height: 12),
                _buildLogItem(
                  context,
                  icon: Icons.image,
                  title: 'Path Image Front Full',
                  content: json[ICEkycKeyResult.pathImageFrontFull],
                ),
                const SizedBox(height: 12),
                _buildLogItem(
                  context,
                  icon: Icons.credit_card,
                  title: 'Path Image Back Full',
                  content: json[ICEkycKeyResult.pathImageBackFull],
                ),
                const SizedBox(height: 12),
                _buildLogItem(
                  context,
                  icon: Icons.credit_card,
                  title: 'Path Image Face Full',
                  content: json[ICEkycKeyResult.pathImageFaceFull],
                ),
                const SizedBox(height: 12),
                _buildLogItem(
                  context,
                  icon: Icons.compare_arrows,
                  title: 'Path Image Face Far Full',
                  content: json[ICEkycKeyResult.pathImageFaceFarFull],
                ),

                _buildLogItem(
                  context,
                  icon: Icons.compare_arrows,
                  title: 'Path Image Face Near Full',
                  content: json[ICEkycKeyResult.pathImageFaceNearFull],
                ),

                _buildLogItem(
                  context,
                  icon: Icons.compare_arrows,
                  title: 'Path Image Face Scan 3D',
                  content: json[ICEkycKeyResult.pathImageFaceScan3D],
                ),
              
                const SizedBox(height: 16),
              ],
            ),
    );
  }

    Widget _buildSafeImage(String? path) {
    if (path == null || path.isEmpty) {
      return const SizedBox.shrink();
    }

    return Image.file(
      File(path),
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _copyAllToClipboard(BuildContext context) async {
    final buffer = StringBuffer();
    final keys = [
      ICEkycKeyResult.clientSessionResult,
      ICEkycKeyResult.cropParam,
      ICEkycKeyResult.pathImageFrontFull,
      ICEkycKeyResult.pathImageBackFull,
      ICEkycKeyResult.pathImageFaceFull,
      ICEkycKeyResult.pathImageFaceFarFull,
      ICEkycKeyResult.pathImageFaceNearFull,
      ICEkycKeyResult.pathImageFaceScan3D,
    ];

    for (final key in keys) {
      final content = json[key];
      if (content != null && content.toString().trim().isNotEmpty) {
        buffer.writeln('$key:');
        buffer.writeln(content);
        buffer.writeln('\n---\n');
      }
    }

    if (buffer.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: buffer.toString()));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Đã sao chép tất cả'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    }
  }

  Future<void> _copyToClipboard(BuildContext context, String? content) async {
    if (content != null && content.trim().isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: content));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Đã sao chép'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                if (isJson && parsedJson?['logID'] != null)
                  TextButton.icon(
                    onPressed: () => _copyToClipboard(context, parsedJson!['logID']?.toString()),
                    icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                    label: const Text(
                      'LogID',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
}
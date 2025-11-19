import 'package:flutter/material.dart';

class NfcScreen extends StatelessWidget {
  const NfcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.nfc,
                          size: 80,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'NFC Reader',
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tính năng đọc thông tin từ chip NFC trên thẻ căn cước sẽ được phát triển trong tương lai.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tính năng đang được phát triển'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Tìm hiểu thêm'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
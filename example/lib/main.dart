import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_plugin_ic_ekyc_example/theme/app_theme.dart';
import 'package:flutter_plugin_ic_ekyc_example/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferenceService.init(await SharedPreferences.getInstance());
  await _setupUIConstraints();
  runApp(const ICEkycApp());
}

class ICEkycApp extends StatelessWidget {
  const ICEkycApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VNPT eKYC  SDK',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const HomeScreen(title: 'VNPT eKYC  SDK'),
      ),
    );
  }
}

Future<void> _setupUIConstraints() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Remove deprecated SystemChrome calls for Android 15 compliance
  // Edge-to-edge is now handled in MainActivity.kt

  if (Platform.isIOS) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  Animate.restartOnHotReload = true;
}
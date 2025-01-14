import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:pembersih_kulkas/view/splash_view.dart';
import 'package:pembersih_kulkas/view/prompt_view.dart';
import 'package:pembersih_kulkas/view/signup_view.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pembersih Kulkas',
      home: SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

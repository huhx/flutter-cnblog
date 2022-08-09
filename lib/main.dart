import 'package:flutter/material.dart';
import 'package:flutter_cnblog/theme/theme.dart';

import 'business/main/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: appThemeData[AppTheme.light],
    );
  }
}

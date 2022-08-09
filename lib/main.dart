import 'package:flutter/material.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'business/main/main_screen.dart';
import 'component/custom_water_drop_header.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const CustomWaterDropHeader(),
      child: MaterialApp(
        home: const MainScreen(),
        theme: appThemeData[AppTheme.light],
      ),
    );
  }
}

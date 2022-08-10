import 'package:flutter/material.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'business/main/main_screen.dart';
import 'component/custom_water_drop_header.dart';

final Logger logger = Logger(printer: PrettyPrinter());

void main() async {
  await dotenv.load(fileName: ".env");
  timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());

  runApp(
    const ProviderScope(child: MainApp()),
  );
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
        localizationsDelegates: const [
          RefreshLocalizations.delegate,
        ],
      ),
    );
  }
}

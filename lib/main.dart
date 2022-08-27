import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblog/business/main/theme_provider.dart';
import 'package:flutter_cnblog/common/constant/timeago_message.dart';
import 'package:flutter_cnblog/theme/theme.dart';
import 'package:flutter_cnblog/util/app_config.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'business/main/main_screen.dart';
import 'component/custom_load_footer.dart';
import 'component/custom_water_drop_header.dart';

final Logger logger = Logger(printer: PrettyPrinter());

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    initResource();
  }

  void initResource() async {
    await initCss();
    timeago.setLocaleMessages('zh', ZhMessages());
    timeago.setDefaultLocale('zh');

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const CustomWaterDropHeader(),
      footerBuilder: () => const CustomLoadFooter(),
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: const CupertinoScrollBehavior(),
            child: child!,
          );
        },
        home: DoubleBack(
          onFirstBackPress: (_) => CommUtil.toast(message: "再按一次退出"),
          child: const MainScreen(),
        ),
        theme: appThemeData[AppTheme.light],
        darkTheme: appThemeData[AppTheme.dark],
        themeMode: ref.watch(themeProvider).themeMode,
      ),
    );
  }

  Future<void> initCss() async {
    final String source = await rootBundle.loadString("assets/css/blog.css");
    AppConfig.save("blog_css", source);

    final String newsSource = await rootBundle.loadString("assets/css/news.css");
    AppConfig.save("news_css", newsSource);

    final String questionSource = await rootBundle.loadString("assets/css/question.css");
    AppConfig.save("question_css", questionSource);

    final String myQuestionSource = await rootBundle.loadString("assets/css/my_question.css");
    AppConfig.save("my_question_css", myQuestionSource);

    final String messageSource = await rootBundle.loadString("assets/css/message.css");
    AppConfig.save("message_css", messageSource);

    final String knowledgeSource = await rootBundle.loadString("assets/css/knowledge.css");
    AppConfig.save("knowledge_css", knowledgeSource);
  }
}

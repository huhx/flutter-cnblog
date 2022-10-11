import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewConfig extends InAppWebViewGroupOptions {
  InAppWebViewConfig() : super(crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true));
}

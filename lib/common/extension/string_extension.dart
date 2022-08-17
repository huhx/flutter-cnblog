extension StringExtension on String {
  String trimQuotation() {
    return replaceAll(RegExp(r'^\"|\"$'), "");
  }
}

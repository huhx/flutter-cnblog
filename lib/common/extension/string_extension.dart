extension StringExtension on String {
  String trimQuotation() {
    return substring(1, length - 1);
  }
}

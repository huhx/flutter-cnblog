extension StringExtension on String {
  String trimQuotation() => replaceAll(RegExp(r'^"|"$'), "");
}

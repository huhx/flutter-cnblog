extension StringExtension on String {
  String trimQuotation() {
    return replaceAll(RegExp(r'^\"|\"$'), "");
  }

  int toInt({int? defaultValue}) {
    return int.tryParse(this) ?? defaultValue!;
  }
}

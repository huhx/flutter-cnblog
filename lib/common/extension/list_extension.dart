extension ListExtension<T> on List<T> {
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}

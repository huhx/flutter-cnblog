import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchProvider = StateNotifierProvider<SearchModel, String>((ref) {
  return SearchModel("");
});

class SearchModel extends StateNotifier<String> {
  SearchModel(super.query);

  void update(String queryString) {
    state = queryString;
  }

  void reset() => state = "";
}

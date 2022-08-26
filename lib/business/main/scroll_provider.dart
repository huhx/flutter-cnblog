import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scrollProvider = StateNotifierProvider<ScrollModel, Map<String, ScrollController>>((ref) {
  final ScrollController blogController = ScrollController();
  final ScrollController newsController = ScrollController();
  final ScrollController questionController = ScrollController();
  final ScrollController instantController = ScrollController();

  final Map<String, ScrollController> map = {
    "blog": blogController,
    "news": newsController,
    "question": questionController,
    "instant": instantController,
  };

  return ScrollModel(map);
});

class ScrollModel extends StateNotifier<Map<String, ScrollController>> {
  ScrollModel(super.state);

  ScrollController get(String type) {
    return state[type]!;
  }

  bool isNotTop(String type) {
    final ScrollController scrollController = state[type]!;
    return scrollController.positions.any((element) => element.pixels != 0.0);
  }

  void scrollToTop(String type) {
    final ScrollController scrollController = state[type]!;
    scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}

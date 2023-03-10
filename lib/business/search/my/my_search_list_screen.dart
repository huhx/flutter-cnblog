import 'package:app_common_flutter/pagination.dart';
import 'package:app_common_flutter/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/search_api.dart';
import 'package:flutter_cnblog/business/search/search_provider.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MySearchListScreen extends ConsumerStatefulWidget {
  final MySearchType searchType;

  const MySearchListScreen(this.searchType, {super.key});

  @override
  ConsumerState<MySearchListScreen> createState() => _MySearchListScreenState();
}

class _MySearchListScreenState extends StreamConsumerState<MySearchListScreen, SearchInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<SearchInfo> searchResults = await searchApi.getMySearchContents(
        widget.searchType,
        pageKey,
        ref.read(searchProvider),
      );
      streamList.fetch(searchResults, pageKey, pageSize: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedView(
      streamList,
      (context, searchList) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: searchList.length,
        itemBuilder: (_, index) => MySearchItem(
          searchList[index],
          key: ValueKey(searchList[index].url),
        ),
      ),
    );
  }
}

class MySearchItem extends StatelessWidget {
  final SearchInfo searchInfo;

  const MySearchItem(this.searchInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CommUtil.toBeDev(),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            children: [
              Html(data: searchInfo.title, style: {
                "strong": Style(
                  color: const Color(0xFFdd4b39),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                )
              }),
              Html(data: searchInfo.summary, style: {
                "strong": Style(
                  color: const Color(0xFFdd4b39),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                )
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (searchInfo.author != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              searchInfo.author!,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        if (searchInfo.diggCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: TextIcon(icon: "like", counts: searchInfo.diggCount!),
                          ),
                        if (searchInfo.commentCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: TextIcon(icon: "comment", counts: searchInfo.commentCount!),
                          ),
                        if (searchInfo.viewCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: TextIcon(icon: "view", counts: searchInfo.viewCount!),
                          )
                      ],
                    ),
                    Text(searchInfo.postDate)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

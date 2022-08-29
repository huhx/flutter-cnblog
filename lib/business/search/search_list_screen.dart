import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/search_api.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchListScreen extends ConsumerStatefulWidget {
  final SearchType searchType;
  final String keyword;

  const SearchListScreen(this.searchType, this.keyword, {super.key});

  @override
  ConsumerState<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends ConsumerState<SearchListScreen> {
  final StreamList<SearchInfo> streamList = StreamList();

  Future<void> _fetchPage(int pageKey, String keyword) async {
    if (streamList.isOpen) {
      final List<SearchInfo> searchResults = await searchApi.getSearchContents(widget.searchType, pageKey, keyword);
      streamList.fetch(searchResults, pageKey, pageSize: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey, widget.keyword), init: widget.keyword.isNotEmpty);

    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<SearchInfo> searchList = snap.data as List<SearchInfo>;

        if (searchList.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const Text("抱歉！没有找到您搜索的相关内容。"),
          );
        }

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            itemCount: searchList.length,
            itemBuilder: (_, index) => SearchItem(searchList[index], widget.searchType, key: ValueKey(searchList[index].url)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streamList.dispose();
    super.dispose();
  }
}

class SearchItem extends StatelessWidget {
  final SearchInfo searchInfo;
  final SearchType searchType;

  const SearchItem(this.searchInfo, this.searchType, {Key? key}) : super(key: key);

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
                            padding: const EdgeInsets.only(right: 8),
                            child: TextIcon(icon: "like", counts: searchInfo.diggCount!),
                          ),
                        if (searchInfo.commentCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TextIcon(icon: "comment", counts: searchInfo.commentCount!),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextIcon(icon: "view", counts: searchInfo.viewCount),
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

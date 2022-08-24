import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/search_api.dart';
import 'package:flutter_cnblog/common/stream_list.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_cnblog/util/comm_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchListScreen extends StatefulWidget {
  final SearchType searchType;
  final String keyword;

  const SearchListScreen(this.searchType, this.keyword, {Key? key}) : super(key: key);

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final StreamList<SearchInfo> streamList = StreamList();

  @override
  void initState() {
    super.initState();
    streamList.addRequestListener((pageKey) => _fetchPage(pageKey));
  }

  Future<void> _fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<SearchInfo> searchResults = await searchApi.getSearchContents(widget.searchType, pageKey, widget.keyword);
      streamList.fetch(searchResults, pageKey, pageSize: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamList.stream,
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final List<SearchInfo> searchList = snap.data as List<SearchInfo>;

        return SmartRefresher(
          controller: streamList.refreshController,
          onRefresh: () => streamList.onRefresh(),
          onLoading: () => streamList.onLoading(),
          enablePullUp: true,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: searchList.length,
            itemBuilder: (_, index) => SearchItem(searchList[index], key: ValueKey(searchList[index].url)),
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

  const SearchItem(this.searchInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CommUtil.toBeDev(),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Column(
            children: [
              Html(data: searchInfo.title),
              Html(data: searchInfo.summary),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (searchInfo.author != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.author!,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      if (searchInfo.diggCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.diggCount!.toString(),
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      if (searchInfo.commentCount != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            searchInfo.commentCount!.toString(),
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          searchInfo.viewCount.toString(),
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Text(searchInfo.postDate)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

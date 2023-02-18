import 'package:app_common_flutter/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/read_log_api.dart';
import 'package:flutter_cnblog/api/search_api.dart';
import 'package:flutter_cnblog/business/home/blog_detail_screen.dart';
import 'package:flutter_cnblog/business/news/news_detail_screen.dart';
import 'package:flutter_cnblog/business/profile/knowledge/knowledge_detail_screen.dart';
import 'package:flutter_cnblog/business/question/question_detail_screen.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/common/stream_consumer_state.dart';
import 'package:flutter_cnblog/common/support/comm_parser.dart';
import 'package:flutter_cnblog/component/text_icon.dart';
import 'package:flutter_cnblog/model/detail_model.dart';
import 'package:flutter_cnblog/model/read_log.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchListScreen extends ConsumerStatefulWidget {
  final SearchType searchType;
  final String keyword;

  const SearchListScreen(this.searchType, this.keyword, {super.key});

  @override
  ConsumerState<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends StreamConsumerState<SearchListScreen, SearchInfo> {
  @override
  Future<void> fetchPage(int pageKey) async {
    if (streamList.isOpen) {
      final List<SearchInfo> searchResults = await searchApi.getSearchContents(widget.searchType, pageKey, widget.keyword);
      streamList.fetch(searchResults, pageKey, pageSize: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    streamList.addRequestListener((pageKey) => fetchPage(pageKey), init: widget.keyword.isNotEmpty);

    return PagedView(
      streamList,
      (context, searchList) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        itemCount: searchList.length,
        itemBuilder: (_, index) => SearchItem(searchList[index], widget.searchType, key: ValueKey(searchList[index].url)),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final SearchInfo searchInfo;
  final SearchType searchType;

  const SearchItem(this.searchInfo, this.searchType, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DetailModel detailModel = DetailModel(
          title: searchInfo.title,
          url: searchInfo.url,
          name: searchInfo.author,
          blogName: searchType == SearchType.blog ? Comm.getNameFromBlogUrl(searchInfo.url) : null,
          commentCount: searchInfo.commentCount ?? 0,
          diggCount: searchInfo.diggCount ?? 0,
        );
        switch (searchType) {
          case SearchType.news:
            context.goto(NewsDetailScreen(detailModel));
            readLogApi.insert(ReadLog.of(type: ReadLogType.news, summary: searchInfo.summary, detailModel: detailModel));
            break;
          case SearchType.blog:
            context.goto(BlogDetailScreen(blog: detailModel));
            readLogApi.insert(ReadLog.of(type: ReadLogType.blog, summary: searchInfo.summary, detailModel: detailModel));
            break;
          case SearchType.question:
            context.goto(QuestionDetailScreen(question: detailModel));
            break;
          case SearchType.knowledge:
            context.goto(KnowledgeDetailScreen(detailModel));
            readLogApi.insert(ReadLog.of(type: ReadLogType.knowledge, summary: searchInfo.summary, detailModel: detailModel));
            break;
        }
      },
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
                        if (searchInfo.viewCount != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
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

import 'package:flutter_cnblog/common/parser/search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return search news result list", () {
    const String string = '''
    <div class="forflow">
        <div class="searchItem">
            <h3 class="searchItemTitle">
                <a target="_blank" href="https://news.cnblogs.com/n/96913/ ">13 种最为荒谬的编程语言</a>
            </h3>
            <!--end: searchItemTitle -->
            <span class="searchCon">
                序源代码。 “<strong>Hello</strong> World” example: HAI CAN HAS STDIO? VISIBLE “HAI WORLD!” KTHXBYE...批编译器。 “<strong>Hello</strong> World” example: "dlroW olleH"&gt;:v ^,_@ 3. Brainfuck Brainfuck，
            </span>
            <!--end: searchCon -->
            <div class="searchItemInfo">
                <span class="searchItemInfo-userName">
                </span>
                <span class="searchItemInfo-publishDate">2011-04-10</span>
                    <span class="searchItemInfo-comments">评论(4)</span>
                    <span class="searchItemInfo-views">浏览(1682)</span>
            </div>
            <div class="searchItemInfo">
                <span class="searchURL">https://news.cnblogs.com/n/96913/ </span>
            </div>
        </div>
    </div> 
    ''';

    final List<SearchInfo> results = SearchParser.parseSearchList(string);

    expect(
      results[0],
      const SearchInfo(
        title: "13 种最为荒谬的编程语言",
        url: "https://news.cnblogs.com/n/96913/",
        summary: '''<span class="searchCon">
                序源代码。 “<strong>Hello</strong> World” example: HAI CAN HAS STDIO? VISIBLE “HAI WORLD!” KTHXBYE...批编译器。 “<strong>Hello</strong> World” example: "dlroW olleH"&gt;:v ^,_@ 3. Brainfuck Brainfuck，
            </span>''',
        viewCount: 1682,
        commentCount: 4,
        postDate: "2011-04-10",
      ),
    );
  });


  test("should return search blog result list", () {
    const String string = '''
    <div class="forflow">
      <div class="searchItem">
          <h3 class="searchItemTitle">
              <a target="_blank" href="https://www.cnblogs.com/harveyChoi/p/hello_jexus.html"><strong>Hello</strong> Jexus</a>
          </h3>
          <!--end: searchItemTitle -->
          <span class="searchCon">
              已经趋于成熟。 这是一个 <strong>Hello</strong> world。感谢Jexus作者宇内流云对吾小白的耐心指导。 
          </span>
          <!--end: searchCon -->
          <div class="searchItemInfo">
              <span class="searchItemInfo-userName">
                      <a href="https://www.cnblogs.com/harveychoi/" target="_blank">海华</a>
              </span>
              <span class="searchItemInfo-publishDate">2013-07-31</span>
                  <span class="searchItemInfo-good">推荐(11)</span>
                  <span class="searchItemInfo-comments">评论(15)</span>
                  <span class="searchItemInfo-views">浏览(2376)</span>
          </div>
          <div class="searchItemInfo">
              <span class="searchURL">https://www.cnblogs.com/harveyChoi/p/hello_jexus.html</span>
          </div>
      </div>
    </div> 
    ''';

    final List<SearchInfo> results = SearchParser.parseSearchList(string);

    expect(
      results[0],
      const SearchInfo(
        title: "<strong>Hello</strong> Jexus",
        url: "https://www.cnblogs.com/harveyChoi/p/hello_jexus.html",
        summary: '''<span class="searchCon">
              已经趋于成熟。 这是一个 <strong>Hello</strong> world。感谢Jexus作者宇内流云对吾小白的耐心指导。 
          </span>''',
        viewCount: 2376,
        author: "海华",
        homeUrl: "https://www.cnblogs.com/harveychoi/",
        commentCount: 15,
        diggCount: 11,
        postDate: "2013-07-31",
      ),
    );
  });
}
import 'package:flutter_cnblog/common/parser/knowledge_parser.dart';
import 'package:flutter_cnblog/model/knowledge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return knowledge base list", () {
    const String string = '''
    <div class="aiticle_item">
      <div class="message_info">
        <div class="msg_title">
          <p>
            <a href="/page/611509/" title="心流：写作、编程和修炼武功的共同法门" target="_blank">心流：写作、编程和修炼武功的共同法门</a>
            <span class="classify_name">程序人生</span>
          </p>
        </div>
        <div class="msg_summary">
          <p>曾经有位朋友对我说，写文章是天下第一的难事。当然在很多人的眼中，这话未必正确。但对于喜欢写作的人来说，能讲出这句话的，基本上可以引为知音了。
            在我的认知中，写作是很难的事；而在所有的文学体裁中，写小说，尤其是写长篇小说，最不容易。 有人说，不对，还有诗歌啊。诗歌才是文学之王。
            的确，...</p>
        </div>
        <div class="msg_tag">
          <span class="view">阅读(3142)</span>&nbsp;
          <span class="recommend">推荐(95)</span>&nbsp;
          <span class="tag"><a href="/tag/%E5%86%99%E4%BD%9C/" class="catalink">写作</a> <a href="/tag/%E7%BC%96%E7%A8%8B/"
                                                                                            class="catalink">编程</a></span>&nbsp;
          发布于&nbsp;<span class="green">2018-12-21 13:41</span>
        </div>
      </div>
      <div class="clear"></div>
    </div>
  ''';

    final List<KnowledgeInfo> knowledgeList = KnowledgeParser.parseKnowledgeList(string);

    expect(knowledgeList.length, 1);
    expect(
      knowledgeList[0],
      KnowledgeInfo(
        id: 611509,
        title: "心流：写作、编程和修炼武功的共同法门",
        url: "https://kb.cnblogs.com/page/611509/",
        summary: '''曾经有位朋友对我说，写文章是天下第一的难事。当然在很多人的眼中，这话未必正确。但对于喜欢写作的人来说，能讲出这句话的，基本上可以引为知音了。
            在我的认知中，写作是很难的事；而在所有的文学体裁中，写小说，尤其是写长篇小说，最不容易。 有人说，不对，还有诗歌啊。诗歌才是文学之王。
            的确，...''',
        category: "程序人生",
        tags: const ["写作", "编程"],
        postDate: DateTime.parse("2018-12-21 13:41"),
        viewCount: 3142,
        diggCount: 95,
      ),
    );
  });
}

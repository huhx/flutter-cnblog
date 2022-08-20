import 'package:flutter_cnblog/common/parser/my_search_parser.dart';
import 'package:flutter_cnblog/model/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return search blog result list", () {
    const String string = '''
    <div class="results">
      <div class="result-item">
          <div class="result-title">
              <a target="_blank" href="https://www.cnblogs.com/huhx/p/dynamicTheoryAdvance.html">
                  java高级----&gt;Java动态代理的原理
              </a>
          </div>
          <a target="_blank" class="result-url" href="https://www.cnblogs.com/huhx/p/dynamicTheoryAdvance.html">
              https://www.cnblogs.com/huhx/p/dynamicTheoryAdvance.html
          </a>
          <div class="result-content">
              name is <strong>huhx</strong> argument id: &lt;/span&gt;1&lt;span style="color: #000000;"&gt; name: <strong>huhx</strong> &lt;...name is <strong>huhx</strong> argument id: &lt;/span&gt;1&lt;span style="color: #000000;"&gt; name: <strong>huhx</strong> &lt;
          </div>
          <div class="result-widget">
              <span>
                  <i class="iconfont icon-shijian" aria-hidden="true"></i>
                  2016-4-6
              </span>
                  <span><i class="iconfont icon-dianzan" aria-hidden="true"></i>18</span>
                  <span><i class="iconfont icon-pinglun" aria-hidden="true"></i>9</span>
                  <span><i class="iconfont icon-liulan" aria-hidden="true"></i>11421</span>
          </div>
      </div>
    </div> 
    ''';

    final List<SearchInfo> results = MySearchParser.parseSearchList(string);

    expect(
      results[0],
      const SearchInfo(
        title: "java高级----&gt;Java动态代理的原理",
        url: "https://www.cnblogs.com/huhx/p/dynamicTheoryAdvance.html",
        summary: '''<div class="result-content">
              name is <strong>huhx</strong> argument id: &lt;/span&gt;1&lt;span style="color: #000000;"&gt; name: <strong>huhx</strong> &lt;...name is <strong>huhx</strong> argument id: &lt;/span&gt;1&lt;span style="color: #000000;"&gt; name: <strong>huhx</strong> &lt;
          </div>''',
        viewCount: 11421,
        commentCount: 9,
        diggCount: 18,
        postDate: "2016-4-6",
      ),
    );
  });


  test("should return search question result list", () {
    const String string = '''
    <div class="results">
      <div class="result-item result-item-question">
          <div class="result-title">
              <a target="_blank" href="https://q.cnblogs.com/q/85127/">ubuntu下载<strong>android</strong>源码</a>
          </div>
          <a target="_blank" href="https://q.cnblogs.com/q/85127/">
              https://q.cnblogs.com/q/85127/
          </a>
          <div class="result-content">
              在虚拟机中的ubuntu下载android5.0源码，下了30多G还没有完成。不知道谁有没有下载过，android5源码需要多大的内存啊！
          </div>
          <div class="result-widget">
              <span>
                  <i class="iconfont icon-shijian" aria-hidden="true"></i>
                  2016-8-14
              </span>
                  <span><i class="iconfont icon-dianzan" aria-hidden="true"></i>0</span>
                  <span><i class="iconfont icon-pinglun" aria-hidden="true"></i>0</span>
                  <span><i class="iconfont icon-liulan" aria-hidden="true"></i>129</span>
          </div>
      </div>
    </div> 
    ''';

    final List<SearchInfo> results = MySearchParser.parseSearchList(string);

    expect(
      results[0],
      const SearchInfo(
        title: "ubuntu下载<strong>android</strong>源码",
        url: "https://q.cnblogs.com/q/85127/",
        summary: '''<div class="result-content">
              在虚拟机中的ubuntu下载android5.0源码，下了30多G还没有完成。不知道谁有没有下载过，android5源码需要多大的内存啊！
          </div>''',
        viewCount: 129,
        commentCount: 0,
        diggCount: 0,
        postDate: "2016-8-14",
      ),
    );
  });
}

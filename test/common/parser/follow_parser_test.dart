import 'package:flutter_cnblog/common/parser/follow_parser.dart';
import 'package:flutter_cnblog/model/follow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should return follow list", () {
    const String string = '''
     <div class="avatar_list">
        <ul>
                <li id="1ab2cf73-e521-e411-8d02-90b11c0b17d6">
                    <a href="/u/opensmarty" title="opensmarty
    关注于2022-04-13">
                        <div class="avatar_pic">
                            <img src="//pic.cnblogs.com/face/662503/20170320120514.png">
                        </div>
                        <div class="avatar_name">
                            opensmarty
                        </div>
                    </a>
                    <a class="edit hide" href="javascript:void(0)" onclick="delFollower('1ab2cf73-e521-e411-8d02-90b11c0b17d6','opensmarty')">删除粉丝</a>
                </li>
                <li id="61981ca8-2897-e611-845c-ac853d9f53ac">
                    <a href="/u/1046875" title="装逼的路上
    关注于2022-03-08">
                        <div class="avatar_pic">
                            <img src="//pic.cnblogs.com/default-avatar.png">
                        </div>
                        <div class="avatar_name">
                            装逼的路上
                        </div>
                    </a>
                    <a class="edit hide" href="javascript:void(0)" onclick="delFollower('61981ca8-2897-e611-845c-ac853d9f53ac','装逼的路上')">删除粉丝</a>
                </li>
        </ul>
    </div>   
    ''';

    final List<FollowInfo> follows = FollowParser.parseFollowList(string);

    expect(follows.length, 2);
    expect(
      follows[0],
      FollowInfo(
        userId: "1ab2cf73-e521-e411-8d02-90b11c0b17d6",
        name: "opensmarty",
        displayName: "opensmarty",
        url: "https://home.cnblogs.com/u/opensmarty",
        avatar: "https://pic.cnblogs.com/face/662503/20170320120514.png",
        followDate: DateTime.parse("2022-04-13"),
      ),
    );
    expect(
      follows[1],
      FollowInfo(
        userId: "61981ca8-2897-e611-845c-ac853d9f53ac",
        name: "1046875",
        displayName: "装逼的路上",
        url: "https://home.cnblogs.com/u/1046875",
        avatar: "https://pic.cnblogs.com/default-avatar.png",
        followDate: DateTime.parse("2022-03-08"),
      ),
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_follow_api.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/common/current_user.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';

import 'follow/follow_screen.dart';

class UserFollowCountInfo extends StatelessWidget {
  final UserInfo user;

  const UserFollowCountInfo(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileInfo>(
      future: userProfileApi.getUserProfile(user.displayName),
      builder: (context, snap) {
        if (!snap.hasData) return const CenterProgressIndicator();
        final UserProfileInfo userProfile = snap.data as UserProfileInfo;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => context.goto(FollowScreen(name: userProfile.name, index: 0)),
              child: Row(
                children: [
                  Text("${userProfile.followCounts}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(width: 2),
                  const Text("关注", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => context.goto(FollowScreen(name: userProfile.name, index: 1)),
              child: Row(
                children: [
                  Text("${userProfile.followerCounts}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(width: 2),
                  const Text("粉丝", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            if (user.displayName != CurrentUser.getUser().displayName)
              FutureBuilder(
                future: userFollowApi.isFollow(user.userId),
                builder: (context, snap) {
                  if (!snap.hasData) return const CenterProgressIndicator();
                  bool isFollow = snap.data as bool;
                  String text = isFollow ? "取消关注" : "关注";

                  return StatefulBuilder(
                    builder: (context, setter) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.white,
                          textStyle: const TextStyle(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text(text),
                        onPressed: () async {
                          if (isFollow) {
                            await userFollowApi.unfollow(user.userId);
                          } else {
                            await userFollowApi.follow(user.userId, user.displayName);
                          }
                          setter(() {
                            isFollow = !isFollow;
                            text = isFollow ? "取消关注" : "关注";
                          });
                        },
                      );
                    },
                  );
                },
              )
          ],
        );
      },
    );
  }
}

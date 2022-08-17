import 'package:flutter/material.dart';
import 'package:flutter_cnblog/api/user_profile_api.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/center_progress_indicator.dart';
import 'package:flutter_cnblog/model/user.dart';
import 'package:flutter_cnblog/model/user_profile.dart';

import 'follow/follow_screen.dart';

class UserFollowCountInfo extends StatelessWidget {
  final User user;

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
          ],
        );
      },
    );
  }
}

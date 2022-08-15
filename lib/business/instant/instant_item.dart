import 'package:flutter/material.dart';
import 'package:flutter_cnblog/common/extension/context_extension.dart';
import 'package:flutter_cnblog/component/circle_image.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_html/flutter_html.dart';

import 'instant_detail_screen.dart';

class InstantItem extends StatelessWidget {
  final InstantInfo instant;

  const InstantItem({Key? key, required this.instant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goto(InstantDetailScreen(instant)),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleImage(url: instant.avatar, size: 36),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(instant.submitter),
                      Row(
                        children: [
                          Text("${instant.commentCounts}回应"),
                          const SizedBox(width: 8),
                          Text(instant.postDate),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Html(data: instant.content)
            ],
          ),
        ),
      ),
    );
  }
}

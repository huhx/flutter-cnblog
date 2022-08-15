import 'package:flutter/material.dart';
import 'package:flutter_cnblog/model/instant.dart';
import 'package:flutter_cnblog/util/comm_util.dart';

class InstantItem extends StatelessWidget {
  final InstantInfo instant;

  const InstantItem({Key? key, required this.instant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CommUtil.toBeDev(),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(instant.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 6),
              Text(
                instant.homeUrl,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}

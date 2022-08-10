import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String url;
  final double size;
  final double borderWidth;

  const CircleImage({
    super.key,
    required this.url,
    this.size = 20,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white, width: borderWidth),
      ),
    );
  }
}

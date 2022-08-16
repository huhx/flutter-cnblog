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
        image: DecorationImage(image: buildImage(url), fit: BoxFit.cover),
        border: borderWidth > 0 ? Border.all(color: Colors.white, width: borderWidth) : null,
      ),
    );
  }

  ImageProvider buildImage(String url) {
    if (url.isEmpty) {
      return const AssetImage('assets/image/logo.png');
    } else {
      return CachedNetworkImageProvider(url);
    }
  }
}

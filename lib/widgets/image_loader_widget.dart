import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';

class ImageLoader extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius; // New parameter

  const ImageLoader({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
  });

  @override
  State<ImageLoader> createState() => ImageLoaderState();
}

class ImageLoaderState extends State<ImageLoader> with TickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget loadDefault() {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero, // Apply borderRadius here
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        height: widget.height ?? 100.h,
        width: widget.width ?? 100.w,
        fit: widget.fit ?? BoxFit.contain,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          padding: EdgeInsets.all(4.adaptSize),
          child: Image.asset(
            AssetsManager.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.zero, // Apply borderRadius here
      ),
      child: loadDefault(),
    );
  }
}

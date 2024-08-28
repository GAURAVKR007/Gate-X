import 'package:flutter/material.dart';

class RoundedImage extends StatefulWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.transparent,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 12.0,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  State<RoundedImage> createState() => _RoundedImageState();
}

class _RoundedImageState extends State<RoundedImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.backgroundColor,
        ),
        child: ClipRRect(
          borderRadius: widget.applyImageRadius
              ? BorderRadius.circular(widget.borderRadius)
              : BorderRadius.zero,
          child: Image(
            fit: widget.fit,
            image: widget.isNetworkImage
                ? NetworkImage(widget.imageUrl)
                : AssetImage(widget.imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}

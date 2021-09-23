import 'package:flutter/material.dart';

class NetworkImageLoader extends StatefulWidget {
  const NetworkImageLoader(
      {Key? key,
      required this.boxFit,
      required this.path,
      required this.defaultImage})
      : super(key: key);
  final String path, defaultImage;
  final BoxFit boxFit;

  @override
  _NetworkImageLoaderState createState() => _NetworkImageLoaderState();
}

class _NetworkImageLoaderState extends State<NetworkImageLoader> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.path,
      fit: widget.boxFit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.network(widget.defaultImage, fit: widget.boxFit);
      },
    );
  }
}

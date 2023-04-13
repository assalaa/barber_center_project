import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageFile extends StatelessWidget {
  final double imageSize;
  final String path;
  const ImageFile({
    required this.imageSize,
    required this.path,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.network(
            path,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(path),
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
          );
  }
}

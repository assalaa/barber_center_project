import 'package:barber_center/widgets/image_file_selected.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadAndShowImage extends StatelessWidget {
  const UploadAndShowImage({
    required this.xFile,
    required this.selectImage,
    super.key,
  });

  final XFile? xFile;
  final Function selectImage;

  @override
  Widget build(BuildContext context) {
    const double size = 145;
    if (xFile == null) {
      return SizedBox(
          height: size,
          width: size,
          child: Container(
            alignment: Alignment.bottomRight,
            height: 130,
            width: 130,
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(size)),
              color: Colors.black38,
              child: InkWell(
                onTap: () => selectImage(),
                borderRadius: const BorderRadius.all(Radius.circular(size)),
                child: const SizedBox(
                  height: 130,
                  width: 130,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ));
    } else {
      return SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(size)),
                child: ImageFile(
                  imageSize: 130,
                  path: xFile!.path,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: const Color(0xff1d1b1b),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => selectImage(),
                    icon: const Icon(
                      Icons.photo_filter_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

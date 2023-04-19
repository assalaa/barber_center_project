import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture(
      {required this.image, required this.updatePhoto, super.key});

  final String? image;
  final Future<void> Function(BuildContext) updatePhoto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 72,
            foregroundImage: image != null ? NetworkImage(image!) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: () => updatePhoto(context),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Styles.primaryColor,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
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

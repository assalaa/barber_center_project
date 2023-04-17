import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({required this.provider, super.key});

  final ProfileScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    final String? profileImage = provider.userModel?.image;

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 72,
            foregroundImage:
                profileImage != null ? NetworkImage(profileImage) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: () async => await provider.updatePhoto(context),
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

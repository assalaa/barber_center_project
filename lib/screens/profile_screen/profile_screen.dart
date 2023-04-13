import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/error_widget.dart';
import 'package:barber_center/widgets/profile_setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenProvider>(
      create: (context) => ProfileScreenProvider(),
      child: Consumer<ProfileScreenProvider>(builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: provider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.userModel == null
                  ? const SnapshotErrorWidget()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LogoutButton(provider: provider),
                          const SizedBox(height: 32),
                          ProfilePicture(
                              profileImage: provider.userModel!.image),
                          const SizedBox(height: 22),
                          FullName(fullName: provider.userModel!.name),
                          const SizedBox(height: 60),
                          const SettingButtons(),
                        ],
                      ),
                    ),
        );
      }),
    );
  }
}

class SettingButtons extends StatelessWidget {
  const SettingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String privacyText = 'Privacy settings';
    const IconData privacyIcon = Icons.privacy_tip_outlined;

    const String bookingHistoryText = 'Booking history';
    const IconData bookingHistoryIcon = Icons.history_toggle_off_rounded;

    return Column(
      children: [
        ProfileSettingButton(
          icon: privacyIcon,
          text: privacyText,
          onTap: () {},
        ),
        ProfileSettingButton(
          icon: bookingHistoryIcon,
          text: bookingHistoryText,
          onTap: () {},
        ),
      ],
    );
  }
}

class FullName extends StatelessWidget {
  const FullName({
    required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(fullName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    this.profileImage,
    super.key,
  });

  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 72,
            backgroundColor: Colors.red,
            foregroundImage:
                profileImage != null ? NetworkImage(profileImage ?? '') : null,
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
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
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    required this.provider,
    super.key,
  });

  final ProfileScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    const String logoutText = 'Logout';

    return TextButton(
      onPressed: () {
        provider.logout();
      },
      child: const Text(
        logoutText,
        style: TextStyle(
          color: Styles.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

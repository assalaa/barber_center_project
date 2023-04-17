import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/widgets/error_widget.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:barber_center/widgets/profile_setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenProvider>(
      create: (context) => ProfileScreenProvider(),
      child: Consumer<ProfileScreenProvider>(
        builder: (context, provider, _) {
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
                            ProfilePicture(provider: provider),
                            const SizedBox(height: 22),
                            FullName(fullName: provider.userModel!.name),
                            const SizedBox(height: 60),
                            const SettingButtons(),
                          ],
                        ),
                      ),
          );
        },
      ),
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

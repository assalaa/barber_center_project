import 'package:barber_center/models/customer_model.dart';
import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/error_widget.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<CustomerModel>(
                future: provider.fetchMyProfile(),
                builder: (context, snapshot) {
                  final CustomerModel? customerModel = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData ||
                      (customerModel != null && customerModel.isEmpty)) {
                    return const SnapshotErrorWidget();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoutButton(provider: provider),
                      const SizedBox(height: 32),
                      ProfilePicture(profileImage: customerModel!.image),
                      const SizedBox(height: 22),
                      FullName(fullName: customerModel.name),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
          ),
        );
      }),
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
      child: CircleAvatar(
        radius: 72,
        foregroundImage:
            profileImage != null ? NetworkImage(profileImage ?? '') : null,
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
      child: Text(
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

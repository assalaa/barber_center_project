import 'package:barber_center/screens/profile_barber/profile_barber_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:barber_center/widgets/service_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BarberProfileScreen extends StatelessWidget {
  const BarberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileBarberProvider>(
      create: (context) => ProfileBarberProvider(),
      child: Consumer<ProfileBarberProvider>(
        builder: (context, provider, _) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 0,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              body: Column(children: [
                if (provider.loading) ...[
                  const CenterLoading()
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LogoutButton(onPressed: provider.logout),
                            const EditButton(),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ProfilePicture(
                          image: provider.barberModel.image,
                          updatePhoto: provider.updatePhoto,
                        ),
                        const SizedBox(height: 22),
                        FullName(
                          userName: provider.userModel.name,
                          //salonName: provider.salonInformationModel?.salonName,
                        ),
                        const SizedBox(height: 10),
                        const Text('Select a skill'),
                        const SizedBox(height: 22),
                        SizedBox(
                          height: AppLayout.getHeight(100),
                          child: ServiceSlider(
                            services: provider.services,
                            deleteFunction: provider.removeService,
                            addFunction: () => Routes.goTo(
                                Routes.addServiceRoute,
                                enableBack: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ]),
            ),
          );
        },
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Routes.goTo(Routes.barberOptionsRoute, enableBack: true),
      icon: const Icon(Icons.edit),
      color: Styles.primaryColor,
    );
  }
}

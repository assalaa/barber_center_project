import 'package:barber_center/screens/barber/profile/profile_barber_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
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
                          image: provider.userModel.image,
                          updatePhoto: provider.updatePhoto,
                        ),
                        const SizedBox(height: 22),
                        FullName(
                          userName: provider.userModel.name,
                          //salonName: provider.salonInformationModel?.salonName,
                        ),
                        const SizedBox(height: 10),
                        Text('Select a skill'),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.services.length,
                            itemBuilder: (context, index) {
                              return ListTile(

                                  //title: Text(provider.services[index].name));
                                  title: Container(
                                      alignment: Alignment.center,
                                      child: ChoiceChip(
                                        label: Text(provider.services[index].name),
                                        selected: provider.isSkillSelected,
                                        onSelected: (value) {
                                          provider.chooseSkill(index);
                                        },
                                        pressElevation: 20,
                                        backgroundColor: provider.isSkillSelected ? Styles.primaryColor : Styles.greyColor,
                                      )));
                            }),
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
